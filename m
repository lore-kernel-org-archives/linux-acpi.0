From: David Mosberger <davidm-o/PNRNCSakrWxDs0y9d3MAC/G2K4zDHf@public.gmane.org>
Subject: Re: entry->irq = entry->link.index (problem 2 of thread [ Re: patch for updating IA64 ACPI fixs into Andy's  ACPI 2.5 tree])
Date: Mon, 23 Jun 2003 11:27:56 -0700
Sender: linux-ia64-admin-WygotPe7DYIabbyE177sbg@public.gmane.org
Message-ID: <16119.18092.184061.37451@napali.hpl.hp.com>
References: <3ACA40606221794F80A5670F0AF15F8427237F@pdsmsx403.ccr.corp.intel.com>
Reply-To: davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-admin-WygotPe7DYIabbyE177sbg@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8427237F-4yWAQGcml64gGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: linux-ia64-admin-WygotPe7DYIabbyE177sbg@public.gmane.org
List-Help: <mailto:linux-ia64-request-WygotPe7DYL3TpFAQG+J+JSyx/Wj9/Chdaaq/uiDbmg@public.gmane.org>
List-Post: <mailto:linux-ia64-WygotPe7DYIabbyE177sbg@public.gmane.org>
List-Subscribe: <http://lists.linuxia64.org/lists/listinfo/linux-ia64>,
	<mailto:linux-ia64-request-WygotPe7DYL3TpFAQG+J+EfZv34bSr6CyrRgqdI+6y4@public.gmane.org>
List-Unsubscribe: <http://lists.linuxia64.org/lists/listinfo/linux-ia64>,
	<mailto:linux-ia64-request-WygotPe7DYL3TpFAQG+J+I4vVymAtk2CuCKOA6ERizqzQB+pC5nmwQ@public.gmane.org>
List-Archive: <http://lists.linuxia64.org/archives//linux-ia64/>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-WygotPe7DYIabbyE177sbg@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Mallick, Asit K" <asit.k.mallick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>>>>> On Mon, 23 Jun 2003 15:13:18 +0800, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> said:

  >> @@ -248,6 +253,8 @@
  >> return_VALUE(0);
  >> }

  >> +	entry->irq = entry->link.index;
  >> +
  >> if (!entry->irq && entry->link.handle) {
  entry-> irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
  >> if (!entry->irq) {

  >> I don't quite understand what this is for.  Anyone know?

  Luming> To understand the meaning of entry->link.index, please
  Luming> reference acpi_get_prt which is in arch/ia64/kernel/acpi.c.
  Luming> There is vector[i].irq = entry->link.index , entry is
  Luming> acpi_prt_entry. And you can look into mp_parse_prt which is
  Luming> in arch/i386/kernel/mpparse.c. There is irq =
  Luming> entry->link.index.

Ah, that's where x86 is doing the transformation.  Thanks for finding
that.  I didn't understand how the old code worked on x86.

Can we do the transformation at the same time on both platforms?
Obviously there is no mpparse.c but perhaps arch/ia64/kernel/acpi.c
could do it.  I wonder though if this scheme would work with hotplug
devices.

In any case, whatever the solution, we clearly should use the same
approach on both platforms.

	--david
