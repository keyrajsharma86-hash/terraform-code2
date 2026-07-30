variable "vms" {}
variable "resource_groups" {}
variable "nics" {}

resource "azurerm_linux_virtual_machine" "vms" {

  for_each = var.vms

  name = each.value.name

  location = var.resource_groups[each.value.resource_group_name].location

  resource_group_name = var.resource_groups[each.value.resource_group_name].name

  size = each.value.size

  admin_username = each.value.admin_username

  admin_password = each.value.admin_password

  disable_password_authentication = false

  network_interface_ids = [
    var.nics[each.value.network_interface_name].id
  ]

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }

  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }
custom_data = base64encode(<<-EOF
    #!/bin/bash
    
    # Update package lists
    apt-get update -y
    
    # Install Nginx
    apt-get install -y nginx
    
    # Start Nginx
    systemctl start nginx
    systemctl enable nginx
    
    # Create custom index.html
    cat > /var/www/html/index.html << 'EOFHTML'
    <!DOCTYPE html>
    <html>
    <head>
        <title>Welcome to Nginx on Azure</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                text-align: center;
                padding: 50px;
                margin: 0;
                height: 100vh;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            h1 { font-size: 3em; margin-bottom: 10px; }
            .info { background: rgba(255,255,255,0.1); padding: 20px; border-radius: 10px; margin-top: 20px; }
            .hostname { font-size: 1.2em; color: #ffd700; }
        </style>
    </head>
    <body>
        <h1> Keyraj Sharma</h1>
        <p>This VM was provisioned by Terraform on Azure</p>
        <div class="info">
            <p><strong>Hostname:</strong> <span class="hostname">$(hostname)</span></p>
            <p><strong>Private IP:</strong> <span class="hostname">$(hostname -I | awk '{print $1}')</span></p>
            <p><strong>Provisioned:</strong> $(date)</p>
        </div>
    </body>
    </html>
    EOFHTML
    
    # Check if Nginx is running
    if systemctl is-active --quiet nginx; then
        echo "✅ Nginx installed and running successfully!"
    else
        echo "❌ Nginx installation failed!"
        exit 1
    fi
    
    # Print VM information
    echo "====================================="
    echo "🌐 VM IP: $(hostname -I | awk '{print $1}')"
    echo "====================================="
  EOF
  )






}