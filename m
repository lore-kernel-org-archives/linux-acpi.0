From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: entry->irq = entry->link.index (problem 2 of thread [ Re: patch for updating IA64 ACPI fixs into Andy's  ACPI 2.5 tree])
Date: Mon, 23 Jun 2003 15:13:18 +0800
Sender: linux-ia64-admin-WygotPe7DYIabbyE177sbg@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8427237F@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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

> @@ -248,6 +253,8 @@
>  		return_VALUE(0);
>  	}
> =20
> +	entry->irq =3D entry->link.index;
> +
>  	if (!entry->irq && entry->link.handle) {
>  		entry->irq =3D acpi_pci_link_get_irq(entry->link.handle, =
entry->link.index);
>  		if (!entry->irq) {

> I don't quite understand what this is for.  Anyone know?

To understand the meaning of entry->link.index, please reference  =
acpi_get_prt  which is in arch/ia64/kernel/acpi.c. =20
There is  vector[i].irq =3D entry->link.index , entry is acpi_prt_entry. =
And you can look into mp_parse_prt=20
which is in arch/i386/kernel/mpparse.c. There is irq =3D =
entry->link.index.

Here,  "entry->irq =3D entry->link.index" just make sure that a default =
initial irq value is assigned according to prt entry.

Thanks,
Luming
