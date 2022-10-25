# --- Keypair Section --- #

# ------------------------------------------------------------------ Admin --- #

resource "aws_key_pair" "kp_sigl_admin" {
  key_name   = "kp_sigl_admin"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJck9Po0od5uxewRS27wXIYIPU8SPFeUqpMXuGVwuY013Y7p2S//tIrfKfjdaRKOZdC/589P3siaXT/EUvNqUlbf0mDP9Zr+FGbVmBsfbq6wMh3BFytu+tJURBXA2qDDid0XdNDtnxIRDbKuUKJtYyLs7JyTPEHqsBPyHLyNg9p8y9xKyajsV+pXZNQ+tedJNU/nXqWWXTsm5JibbdbDvZ10udW5aSwjlEmsug5FN+B54I8Uxsux2pnjn8i4Pn3PD+F5aqzZs/SnmOIPQpP31hLR3oZ8yroHBRQSeHymqvyWemGoPqdKnjCX7LSFF3Y608ObJPZm3KjdZHs9dBfA/wMwCWhU0drCAbum/V3xi/vZf2T6ByDnvbP/VbNKtvc6QEZWTgF3LWDhlO1aUpxVGZZxOfS3HSNiYaLXpenPCRQ7x1QCC0dWIJKkOsMF3QsVntL0MYBljOeejWpmCIXy3Abv7s02cvAJJSGIcVGV47nlsEhKlup9EcBstVWGWOjj8= milann@milann"
  tags = {
    Terraform   = "true"
    Environment = "admin"
  }
}


# ----------------------------------------------------------------- Alexis --- #

resource "aws_key_pair" "kp_alexis_boissiere" {
  key_name   = "kp_alexis_boissiere"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDVLSqV85Ju2EPItM7JaYFxBwZed5cvX5zJ+4gwD8J5ZeynlbqzwE2hOLgUnWCGu1Z76DtVttdkUzWfcZb5CeaYjXCENNas3IiQABScQeXYJYd+Ai3awyy3YdFQx4+zoCf6/DE2alqeVoGphcQVPkKqMJpROVEvjsbKFG3zLRl0C3ULp8mXfNbqtlW+M6FvfJRS1R1gv2fakZQBA+WXula7KutZHxZg+BO31M8ZN2ee8CCp6AxFQZc5qqXhA9kNuaq5v4C2JpUdkeqjFsfL9chVplYYjQhqkPLin1Jm1iJ7ldzoI1urnM9c3aiER4KPrhFTubWSi5XmOWHj7g/37y+lM4dbSYCRN4PS2PKvkHqo5nReEFX/5dlKZhOwpFVpk7U1GdHSxvjWtJFsnYykKKPRYz18IGaN3x3MyPfYNCChGhFlltTmKrOILbR8VgVXDTrqODthqorzbEpmJAV1ke92wwJTBU3CBRYiP9f3GtOyfxNfqSthB9VfG02jJP2RpaU= alexis@alexis-G551JM"
  tags = {
    Terraform   = "true"
    Environment = "admin"
  }
}


# ----------------------------------------------------------------- Milann --- #

resource "aws_key_pair" "kp_milann_guitton" {
  key_name   = "kp_milann_guitton"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJck9Po0od5uxewRS27wXIYIPU8SPFeUqpMXuGVwuY013Y7p2S//tIrfKfjdaRKOZdC/589P3siaXT/EUvNqUlbf0mDP9Zr+FGbVmBsfbq6wMh3BFytu+tJURBXA2qDDid0XdNDtnxIRDbKuUKJtYyLs7JyTPEHqsBPyHLyNg9p8y9xKyajsV+pXZNQ+tedJNU/nXqWWXTsm5JibbdbDvZ10udW5aSwjlEmsug5FN+B54I8Uxsux2pnjn8i4Pn3PD+F5aqzZs/SnmOIPQpP31hLR3oZ8yroHBRQSeHymqvyWemGoPqdKnjCX7LSFF3Y608ObJPZm3KjdZHs9dBfA/wMwCWhU0drCAbum/V3xi/vZf2T6ByDnvbP/VbNKtvc6QEZWTgF3LWDhlO1aUpxVGZZxOfS3HSNiYaLXpenPCRQ7x1QCC0dWIJKkOsMF3QsVntL0MYBljOeejWpmCIXy3Abv7s02cvAJJSGIcVGV47nlsEhKlup9EcBstVWGWOjj8= milann@milann"
  tags = {
    Terraform   = "true"
    Environment = "admin"
  }
}


# ---------------------------------------------------------------- Clement --- #

resource "aws_key_pair" "kp_clement_dailly" {
  key_name   = "kp_clement_dailly"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7kqri9dNIe4iF3tshdhGcjvDkXZ76wEZ4TTBmh49KgATYFZkdV5yGG7jw69f9u7ieWwF5HTz7VMxnYK97Dw+akUTQZuTgIRshdY1bl5xpvzFX5xG3pH1laXQJBmGXQNu/I9qjD1Zz9QhYGCNh5BouFPb39U61GKq9iaAl5ZMlHPyuJ6lWhOkvj4K2Zpsle+19yvYh/pKKVLP7a9UBWqk7pVBqcRFixodif1ZKLZcDu/Mhq6HsZpOs0WrT6EaDTUmi2Yr5x6TNGDcv4f6kd0WuDZ80qjKlCF6oHkCYhpZgAFiesopXGIfP4c1B9j5JtjO9a3WUSKPMRIQgKi4f98p57AO0t2oBjWX3FK4l9zdhRn6esVGv+BprDlxMNjabX+Jcq3Rl6lW0EJBF38h7pCmYAxvHz5iAKJGII/uiw8fXO7CKArB4u7fNXob75a4DkpYADlYMi0/NKQDNnRLNkPbe2Qdvoia8OrVSLOPyu9FtjtgJCwuKBT0RqVY28amhyms= virgiledailly@LAPTOP-IEVTMC0N"
  tags = {
    Terraform   = "true"
    Environment = "admin"
  }
}


# ----------------------------------------------------------------- Benoit --- #

resource "aws_key_pair" "kp_benoit_gornet" {
  key_name   = "kp_benoit_gornet"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCbsjMRSOLvTsjw58UhDkZflqHF6+EUzLsPbq19azHiMfkpZXh/k8lh8TAlfTZvleP/FCFUpgYY+W32VWJM60qrjPOsi3DrQTpWF25Ea0VHkxym11UpyY93YZ/9DRmEGZ/+SmtQT+lgDwp3AibYxRIPJ5eFyKrLG+DjWHJ+6SblPH41knlNoLlhoyhvvzDyd8kykLDeU7ev06X+xnmG1QfwHj20zfd/PPCwyb6SQBbMXkVGaOavfnzgHkNkL/QfaPG/a3G4Qy7bMKqIM22cz07BFhHrIRCKCDOAs3fHZdxWLFtXH495E8uz6JnCV9bpplo5dqklneu9b4XBUwwOMJGmas1GbQGHEmpF5J7E6bze3sxG0c+WGGyknzV9t+aFwbNt9TV96f28UuOQEk9d+fBYF3oUSHEX2ZsAcxSJss4iIoH+ekUBnp21wiWeudTC/9zPm/6VJUKhxZIz++/D/UJtYVQzGHClc1WRX3HeAmo2XGjDWc6cEmdfsxBT58DB4F0= ben@benoit-laptop"
  tags = {
    Terraform   = "true"
    Environment = "admin"
  }
}


# ---------------------------------------------------------------- Aymeric --- #

resource "aws_key_pair" "kp_aymeric_olivaux" {
  key_name   = "kp_aymeric_olivaux"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDEM1DXRAQ+KICXJCml4DR/TV+Z7BLFxBE+bFJscCvfuDgSIQMn/D/utp57bSxiQTvJ0hxbptFOBsb4SxbZd3/yQBmoAG8Qo/qE+MQC7zkMHkKFgUmFCdwePTQuedprOxPT8cQ+1GMzERhiw/W18IXv5KQYWb4FYKLnWb+j552jnlNd9RNXFIiQTg51PFtZsNXZpxRctTcQgClWa3rRpV614r7L5W+/hTWegGhIe7nXjmA8IwNIF8E6LJdm/hgNYlS96v4CrcCOGh4F5ssm4z+aEqh671/clSHgDxb4b/uvkgypjZwRzrx89ANaMOD4nAGxbihsRlIVjhJ1LT4gmVJcK0yJwPgZuaXSKWPIQJrZ9fUazxaquJXPRgW+OgS/mHM2vXjQCtmwH5ez27PdnQipgFtCQ7c5bNbVGDw2tDt5ZdjW9I2tyg3mPuCpTcKdDVUsxQb3k8mKTcaC9qgRzsF2WwRJghY5QmTbyfMonVYpSHDpMD3OpJxafiXe7lxIBYDgu7yI42UcFtSHyRssdPKdgf0WAWpZA9Fx0PUCieaMwx+qkm7TEhvn8gdX9wvPNovoArPC39RtdV/PBg0DF/pDqGR/k3y/TJkSGf+m1EBXY9tZmHn9Q1pwxaBk/p+ctgzcVs+fNS2THYV+qvHqSMTz4vmStMArJe1PFOFe5YLtFw== aymeric@PC-Aymeric-2"
  tags = {
    Terraform   = "true"
    Environment = "admin"
  }
}


# ------------------------------------------------------------------ Liann --- #

resource "aws_key_pair" "kp_liann_pelhate" {
  key_name   = "kp_liann_pelhate"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4JvUh7dYrYu6sHS9Ou+WZFva18P+YPGSRolkvdsLK/4UGOjthoYR8EmUgsAj9aDpZULFQgdzSiG3sgNrOZmqm9l1fP2hX/+sj7Yj6ZPRScFX8L9k9o48/Lc47Mt2iAXoPe/eCxYS4k7zcNE+uBr9uY7cg4nxt+TA4X+ELepCX5D2jgDMGC8aOsrBdwscIXjL5863f/UuieeAubr6LCNAOrtkH7sbwLZxFJLDnJ98ADAjfS4RlI/k0yTUnrepYRj58HJHAuk2T4Fr3WumRrxMJGFqAwwQdhT9SQ0/iqcBE3FvQ+kSKJ6/vao90HJ+dUJrXxHUzh01X9ZsKX/a9CT2fuwSslIos/AKZ4OpUos2OllI/CbpOCmiol9tuM1JLzAUGGp7EqU8z3prgPhe3mEjorSU7iDKUnvIvFFEzR6R2gKUXzHItHaaQvgsw/02hhCPRAOk1YlU/xQ1Qy27iD5gz7aeEEkt98smFKntpgYgc4nVmweTt2SqyWNPHZdRWm5M= liannpelhate@Lianns-MacBook-Pro.local"
  tags = {
    Terraform   = "true"
    Environment = "admin"
  }
}