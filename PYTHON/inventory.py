from flask import Flask, render_template, request, redirect, url_for, Response
import sqlite3
import csv
from reportlab.platypus import SimpleDocTemplate, Table
from reportlab.lib.pagesizes import letter

app = Flask(__name__)

# Chemin vers la base de données SQLite
DB_PATH = 'inventory.db'

# Fonction pour créer la table dans la base de données
def create_table():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute('''CREATE TABLE IF NOT EXISTS inventory (
                      colonne1 TEXT,
                      colonne2 TEXT,
                      colonne3 TEXT,
                      colonne4 TEXT,
                      colonne5 TEXT,
                      colonne6 TEXT,
                      colonne7 TEXT,
                      colonne8 TEXT
                      )''')
    conn.commit()
    conn.close()

# Fonction pour insérer une entrée dans la base de données
def insert_entry(colonne1, colonne2, colonne3, colonne4, colonne5, colonne6, colonne7, colonne8):
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute('''INSERT INTO inventory (colonne1, colonne2, colonne3, colonne4, colonne5, colonne6, colonne7, colonne8)
                      VALUES (?, ?, ?, ?, ?, ?, ?, ?)''', (colonne1, colonne2, colonne3, colonne4, colonne5, colonne6, colonne7, colonne8))
    conn.commit()
    conn.close()

# Fonction pour supprimer un élément de la base de données
def delete_item(id):
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute('''DELETE FROM inventory WHERE id = ?''', (id,))
    conn.commit()
    conn.close()

# Route pour afficher le formulaire de saisie
@app.route('/')
def index():
    return render_template('index.html')

# Route pour traiter les données du formulaire
@app.route('/add', methods=['POST'])
def add_entry():
    colonne1 = request.form['colonne1']
    colonne2 = request.form['colonne2']
    colonne3 = request.form['colonne3']
    colonne4 = request.form['colonne4']
    colonne5 = request.form['colonne5']
    colonne6 = request.form['colonne6']
    colonne7 = request.form['colonne7']
    colonne8 = request.form['colonne8']
    insert_entry(colonne1, colonne2, colonne3, colonne4, colonne5, colonne6, colonne7, colonne8)
    return redirect(url_for('index'))

# Route pour afficher toutes les entrées de l'inventaire
@app.route('/inventory')
def inventory():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM inventory''')
    entries = cursor.fetchall()
    conn.close()
    return render_template('inventory.html', entries=entries)

# Définition de la fonction effectuer_recherche(query)
def effectuer_recherche(query):
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM inventory WHERE colonne1 LIKE ? OR colonne2 LIKE ? OR colonne3 LIKE ? OR colonne4 LIKE ? OR colonne5 LIKE ? OR colonne6 LIKE ? OR colonne7 LIKE ? OR colonne8 LIKE ?''', 
                   ('%' + query + '%', '%' + query + '%', '%' + query + '%', '%' + query + '%', '%' + query + '%', '%' + query + '%', '%' + query + '%', '%' + query + '%'))
    results = cursor.fetchall()
    conn.close()
    return results

# Route pour la recherche
@app.route('/search', methods=['GET'])
def search():
    query = request.args.get('query')

    # Vérifiez d'abord si une requête a été effectuée
    if query:
        # Effectuez la recherche dans la base de données en fonction de la requête
        # Stockez les résultats dans une variable (par exemple, results)
        results = effectuer_recherche(query)
    else:
        # Si aucune requête n'a été effectuée, initialisez results à une liste vide
        results = []

    return render_template('search.html', query=query, entries=results)

# Route pour traiter la suppression d'un élément
@app.route('/delete/<int:id>')
def delete(id):
    delete_item(id)
    return redirect(url_for('inventory'))

# Route pour exporter en CSV
@app.route('/export/csv')
def export_csv():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM inventory''')
    inventory_data = cursor.fetchall()
    conn.close()
    output = generate_csv(inventory_data)
    return Response(output, mimetype='text/csv', headers={'Content-Disposition': 'attachment;filename=inventory.csv'})

# Route pour exporter en PDF
@app.route('/export/pdf')
def export_pdf():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM inventory''')
    inventory_data = cursor.fetchall()
    conn.close()
    output = generate_pdf(inventory_data)
    return Response(output, mimetype='application/pdf', headers={'Content-Disposition': 'attachment;filename=inventory.pdf'})

# Fonction pour générer un fichier CSV à partir des données d'inventaire
def generate_csv(data):
    with open('inventory.csv', 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        # Écrire les en-têtes de colonnes
        writer.writerow(['colonne1', 'colonne2', 'colonne3', 'colonne4', 'colonne5', 'colonne6', 'colonne7', 'colonne8'])
        # Écrire les données
        writer.writerows(data)
    return 'inventory.csv'

# Fonction pour générer un fichier PDF à partir des données d'inventaire
def generate_pdf(data):
    filename = 'inventory.pdf'
    doc = SimpleDocTemplate(filename, pagesize=letter)
    table_data = [['colonne1', 'colonne2', 'colonne3', 'colonne4', 'colonne5', 'colonne6', 'colonne7', 'colonne8']] + data
    table = Table(table_data)
    doc.build([table])
    return 'inventory.pdf'


if __name__ == '__main__':
    create_table()
    app.run(host='0.0.0.0', port=8888, debug=True)
