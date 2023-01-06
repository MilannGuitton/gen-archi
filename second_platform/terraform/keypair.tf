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

/* data "aws_key_pair" "kp_sigl_admin" {
  key_name = "kp_sigl_admin"
} */