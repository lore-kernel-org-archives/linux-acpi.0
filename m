From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Strange interpreter behaviour
Date: Mon, 16 Jan 2006 10:27:50 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AB2770B@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>
>Sorry, seems I missed the main plot ;-)
>In case \_SB.INV7 is 0, the _CST method returns a CST object with a C3 
>and C4 State. If it is 1 I only get the "NOC3" (see above) CST object.
>I can call the _L17 method as often as I want and it seems I 
>allways get 
>a clean fresh CST with only C1 and C2. That's why I assume that 
>something with setting the \_SB.INV7 register is not right. I 
>mentioned 
>this a while ago in a bug : 
>http://bugzilla.kernel.org/show_bug.cgi?id=4485

Not sure, but I think you need to do further investigation.
Are you sure _CST always exits with Return (NOC3).

ACST contains C3 state?


                If (\_SB.INV7) 
                { 
                    Return (NOC3) 
                } 
 
                If (\_SB.BATO) 
                { 
                    Return (BCST) 
                } 
                Else 
                { 
                    Return (ACST) 
                } 
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
