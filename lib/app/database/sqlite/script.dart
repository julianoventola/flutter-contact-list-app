final createTable = '''
  CREATE TABLE contact(
    id INTEGER PRIMARY KEY NOT NULL, 
    nome VARCHAR(40) NOT NULL, 
    telefone CHAR(16) NOT NULL, 
    email VARCHAR(80) NOT NULL, 
    url_avatar VARCHAR(300) NOT NULL
  )
''';

final insert1 = '''
INSERT INTO contact (
  nome, telefone, email, url_avatar
) VALUEs (
 'Juliano', '1144774411', 'juliano@email.com', 'https://avatars.githubusercontent.com/u/28475558?s=400&u=350ae7479c8b1317f03ce43df6de43cbfdd20eb7&v=4'
)
''';

final insert2 = '''
INSERT INTO contact (
  nome, telefone, email, url_avatar
) VALUEs (
 'Maria', '1245682236', 'maria@email.com', 'https://avatars.githubusercontent.com/u/28475558?s=400&u=350ae7479c8b1317f03ce43df6de43cbfdd20eb7&v=4'
)
''';

final insert3 = '''
INSERT INTO contact (
  nome, telefone, email, url_avatar
) VALUEs (
 'Joao', '1345299584', 'joao@email.com', 'https://avatars.githubusercontent.com/u/28475558?s=400&u=350ae7479c8b1317f03ce43df6de43cbfdd20eb7&v=4'
)
''';
