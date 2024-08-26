import psycopg2
from flask import Flask, request, render_template


app = Flask(__name__)

def create_connection():
    conn = psycopg2.connect(
        dbname="DMQL_Project",  
        user="postgres",       
        password="Chiru@0217",        
        host="localhost",       
        port="5432"          
    )
    return conn

def authenticate(customer_id):
    conn = create_connection()
    cursor = conn.cursor()
    
    cursor.execute("SELECT * FROM \"customers\" WHERE customer_id = %s", (customer_id,))
    user = cursor.fetchone()
    
    if user:
        return True
    else:
        return False

@app.route('/')
def login():
    return render_template('web_page.html')

@app.route('/login', methods=['POST'])
def log():
    customer_id = request.form['username']
    password = request.form['password']
    if authenticate(customer_id) and password == 'Chiru':
        #return redirect(url_for('home'))
            conn = create_connection()
            cursor = conn.cursor()
            query = """
            SELECT DISTINCT(styles.prod_name)
            FROM styles
            WHERE section_no IN (
                SELECT DISTINCT(sections.section_no)
                FROM sections 
                NATURAL JOIN (
                    SELECT section_no
                    FROM styles
                    WHERE prod_name IN (
                        SELECT DISTINCT(styles.prod_name)
                        FROM purchases
                        NATURAL JOIN styles
                        NATURAL JOIN sections
                        WHERE customer_id = %s
                    )
                ) AS f
            )
            LIMIT 20;
            """
            cursor.execute(query, (customer_id,))
            results = cursor.fetchall()
            cursor.close()
            conn.close()
            return render_template('home.html', results = results)
    else:
        return render_template('web_page.html', error = 'Invalid credentials. Try again.')


@app.route('/home')
def home():
    return render_template('home.html')

@app.route('/clicked')
def clicking():
    #data = request.get_json()
    id = request.args.get('id')
    if id == 'mens':
        conn = create_connection()
        cursor = conn.cursor()
        query = """
        select distinct(prod_name)
        from styles 
        where section_no in (select section_no from sections where section_name like '%Men%')
        """
        cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('mens.html', results=results)

    elif id == 'women':
        conn = create_connection()
        cursor = conn.cursor()
        query = """
        select distinct(prod_name)
        from styles 
        where section_no in (select section_no from sections where section_name like '%Women%' or section_name like '%Ladies%')
        """
        cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('women.html', results=results)

    elif id == 'kids':
        conn = create_connection()
        cursor = conn.cursor()
        query = """
        select distinct(prod_name)
        from styles 
        where section_no in (select section_no from sections where section_name like '%Kids%')
        """
        cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('kids.html', results=results)

    elif id == 'baby':
        conn = create_connection()
        cursor = conn.cursor()
        query = """
        select distinct(prod_name)
        from styles 
        where section_no in (select section_no from sections where section_name like '%Baby%')
        """
        cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('baby.html', results=results)
    return render_template('home.html')

@app.route('/search', methods=['POST'])
def search():
    s_query = request.form['query']
    conn = create_connection()
    cursor = conn.cursor()
    all_results = []
    for i in s_query.split():
        query = f"""
        select prod_name from products where prod_name like '%{i}%';
        """
        cursor.execute(query)
        results = cursor.fetchall()
        all_results.extend(results)

    cursor.close()
    conn.close()
    if all_results:
        return render_template('search_results.html', answer = s_query ,results = all_results)
    else:
        return render_template('home.html', error = 'No products found')


if __name__ == '__main__':
    app.run(debug = False, port = 5001)
