From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Introduce pci_raw_ops
Date: Thu, 19 Jun 2003 20:40:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030619194026.GG24357@parcelfarce.linux.theplanet.co.uk>
References: <20030619191859.GF24357@parcelfarce.linux.theplanet.co.uk> <16114.3927.291190.349794@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16114.3927.291190.349794-o/PNRNCSakrWxDs0y9d3MAC/G2K4zDHf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 19, 2003 at 12:30:31PM -0700, David Mosberger wrote:
>   Matthew> I've booted it on a generic K6 box.
> 
> diff -u -p -r1.8 pci.c
> --- a/arch/ia64/pci/pci.c	14 Jun 2003 22:14:34 -0000	1.8
> +++ a/arch/ia64/pci/pci.c	19 Jun 2003 19:11:48 -0000
> 
> -struct pci_ops *pci_root_ops = &pci_sal_ops;	/* default to SAL */
> +struct pci_ops *pci_root_ops = {
> +	.read = pci_read,
> +	.write = pci_write,
> +}
> 
> Does this really compile?

No.  I made the same mistake for x86, and I think I fixed the ia64 mistake
in the wrong tree.  For a variety of reasons, I don't have a recent enough
ia64 tree that'll compile.  BTW, fixing this breaks SN2, but I spoke with
Jesse Barnes about it and he wants to change all that code around anyway.

Greg, do you want to just remove this * or do you want another 20k diff?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
