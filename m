From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] acpi_irq_to_vector()
Date: Mon, 23 Jun 2003 14:15:07 +0800
Sender: linux-ia64-admin-WygotPe7DYIabbyE177sbg@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8427237E@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ia64-admin-WygotPe7DYIabbyE177sbg@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: linux-ia64-admin-WygotPe7DYIabbyE177sbg@public.gmane.org
List-Help: <mailto:linux-ia64-request-WygotPe7DYL3TpFAQG+J+JSyx/Wj9/Chdaaq/uiDbmg@public.gmane.org>
List-Post: <mailto:linux-ia64-WygotPe7DYIabbyE177sbg@public.gmane.org>
List-Subscribe: <http://lists.linuxia64.org/lists/listinfo/linux-ia64>,
	<mailto:linux-ia64-request-WygotPe7DYL3TpFAQG+J+EfZv34bSr6CyrRgqdI+6y4@public.gmane.org>
List-Unsubscribe: <http://lists.linuxia64.org/lists/listinfo/linux-ia64>,
	<mailto:linux-ia64-request-WygotPe7DYL3TpFAQG+J+I4vVymAtk2CuCKOA6ERizqzQB+pC5nmwQ@public.gmane.org>
List-Archive: <http://lists.linuxia64.org/archives//linux-ia64/>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-WygotPe7DYIabbyE177sbg@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Mallick, Asit K" <asit.k.mallick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

To remove the ugly ifdef in the common part of ACPI code,=20
I think the simple way is to define a acpi_irq_to_vector in =
arch/i386/acpi which only return acpi_fadt.sci_int.=20
Or someone can invent a method that can return correct value for each =
platform.

Thanks,
Luming

-----Original Message-----
From: Matthew Wilcox [mailto:willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org]
Sent: 2003?6?6? 3:23
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] acpi_irq_to_vector()



In the 2.5 ia64 patch, there's a lot of places which look like this:

@@ -251,7 +251,14 @@
        irq =3D acpi_fadt.sci_int;

 #ifdef CONFIG_IA64
-       irq =3D gsi_to_vector(irq);
+       int vector;
+
+       vector =3D acpi_irq_to_vector(irq);
+       if (vector < 0) {
+               printk(KERN_ERR PREFIX "SCI (IRQ%d) not registerd\n", =
irq);
+               return AE_OK;
+       }
+       irq =3D vector;
 #endif
        acpi_irq_irq =3D irq;

ok, we renamed gsi_to_vector to acpi_irq_to_vector(); that's fine.
But we still have that ugly ifdef in there.  Any resistance to defining
acpi_irq_to_vector to simply return its value on non-ia64 platforms?

Then it'd look like:

	irq =3D acpi_fadt.sci_int;
	vector =3D acpi_irq_to_vector(irq);
	if (vector < 0) {
		printk(KERN_ERR PREFIX "SCI (IRQ%d) not registered\n", irq);
		return AE_OK;
	}
	acpi_irq_irq =3D vector;
	acpi_irq_handler =3D handler;
	acpi_irq_context =3D context;
	if (request_irq(vector, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
...	=09

--=20
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead =
bodies.
Do you think I want to have an academic debate on this subject?" -- =
Robert Fisk


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel
