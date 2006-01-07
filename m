From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Strange interpreter behaviour
Date: Sat, 07 Jan 2006 18:18:22 +0100
Message-ID: <43BFF7DE.1000909@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hey,
I got an ASUS M6, which contains some strange _CST related ASL code.
In the _CST method there is a check, if \_SB.INV7 is set :
                 If (\_SB.INV7)
                 {
                     Return (NOC3)
                 }
This seems to always return true. There is also the method \_GPE:_L17 
which just inverts \_SB.INV7 and sends a signal to refetch the CST Object :
           Method (_L17, 0, NotSerialized)
         {
             If (\_SB.INV7)
             {
                 Store (0x00, \_SB.INV7)
             }
             Else
             {
                 Store (0x01, \_SB.INV7)
             }

             Notify (\_PR.CPU1, 0x81)
         }

Now I called the _L17 method manually :
echo "0:\\_GPE:_L17:\\_GPE:_L17:10001:1" > /proc/acpi/hotkey/poll_config
echo "10001:0:1:0" > /proc/acpi/hotkey/action

What I noticed is that every time I call the action, my C-State usage 
counter gets reset to zero. From that behaviour I would follow, that the 
L17 method was executed and the CST Object was refetched. So there seems 
to be an error in setting the \_SB.INV7 bit/register/whatever. (I assume 
0 is false an 1 is true in ASL if-clauses ?)
Greets
    Janosch
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
