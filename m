From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Userspace ACPI interpreter ( was RE: [RFC] dev_acpi: support for userspace access to acpi)
Date: Fri, 29 Oct 2004 06:58:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041029045858.GL11384@wotan.suse.de>
References: <3ACA40606221794F80A5670F0AF15F84041ABFFA@pdsmsx403> <418085B0.30208@intel.com> <20041028152404.GB7902@thunk.org> <1099025292.5402.200.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1099025292.5402.200.camel@d845pe>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Theodore Ts'o <tytso-3s7WtUTddSA@public.gmane.org>, Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> [ It would be sort of neat if we could built the core ACPI support in
> some kind of modular way such that that we could have it at boot-time,
> if we need it, but optionally unload it at run-time if it turned out the
> target system didn't need it. ]

It would be possible with some Makefile hacks. Basically you would need
to objcopy the ACPI object files and rename .text*/.data* to 
a different acpi specific name. Then you can give it an special 
area in the vmlinux.lds and possibly free it.

I agree with you that it's better kept in the kernel.

> Static Kernel Size:
>    text    data     bss     dec     hex filename
>  144533    5608    4920  155061   25db5 drivers/acpi/built-in.o

Hmm, this used to be smaller, no? Perhaps someone going over
bloat-o-meter[1] output to an older version would be useful.
There is probably some low hanging fruit.

-Andi

[1] ftp://ftp.firstfloor.org/pub/ak/perl/bloat-o-meter



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
