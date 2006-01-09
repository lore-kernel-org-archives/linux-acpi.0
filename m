From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Strange interpreter behaviour
Date: Mon, 9 Jan 2006 13:58:46 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AA37537@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>I got an ASUS M6, which contains some strange _CST related ASL code.
>In the _CST method there is a check, if \_SB.INV7 is set :
>                 If (\_SB.INV7)
>                 {
>                     Return (NOC3)
>                 }
>This seems to always return true. There is also the method \_GPE:_L17 
>which just inverts \_SB.INV7 and sends a signal to refetch the 
>CST Object :
>           Method (_L17, 0, NotSerialized)
>         {
>             If (\_SB.INV7)
>             {
>                 Store (0x00, \_SB.INV7)
>             }
>             Else
>             {
>                 Store (0x01, \_SB.INV7)
>             }
>
>             Notify (\_PR.CPU1, 0x81)
>         }
>
>Now I called the _L17 method manually :
>echo "0:\\_GPE:_L17:\\_GPE:_L17:10001:1" > 
>/proc/acpi/hotkey/poll_config
>echo "10001:0:1:0" > /proc/acpi/hotkey/action
>
>What I noticed is that every time I call the action, my C-State usage 
>counter gets reset to zero. From that behaviour I would 

Please show  /proc/acpi/processor/power .

>follow, that the 
>L17 method was executed and the CST Object was refetched. 
>there seems 
>to be an error in setting the \_SB.INV7 bit/register/whatever. 
>(I assume 
>0 is false an 1 is true in ASL if-clauses ?)

Don't understand what is wrong.
Please clearly point it out.

Thanks,
Luming

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
