From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [ACPI] ACPI blacklisting: move year blacklist into acpi/blacklist.c
Date: Wed, 1 Oct 2003 13:24:12 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031001122412.GJ24824@parcelfarce.linux.theplanet.co.uk>
References: <20031001101826.GA3503@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031001101826.GA3503-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 01, 2003 at 12:18:26PM +0200, Pavel Machek wrote:
> AFAICS. It also adds some externs to include/linux/acpi.h, but I
> believe *way* more externs are needed. Please apply,

> --- /usr/src/tmp/linux/include/linux/acpi.h	2003-08-27 12:00:48.000000000 +0200
> +++ /usr/src/linux/include/linux/acpi.h	2003-10-01 11:53:51.000000000 +0200
> @@ -403,8 +403,8 @@
>  
>  struct pci_dev;
>  
> -int acpi_pci_irq_enable (struct pci_dev *dev);
> -int acpi_pci_irq_init (void);
> +extern int acpi_pci_irq_enable (struct pci_dev *dev);
> +extern int acpi_pci_irq_init (void);

Why do they need to be externs?  The comp.lang.c FAQ suggests they don't
have to be.

http://www.eskimo.com/~scs/C-faq/q1.11.html

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
