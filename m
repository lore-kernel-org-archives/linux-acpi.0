From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI blacklisting: move year blacklist into acpi/blacklist.c
Date: Wed, 1 Oct 2003 15:31:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031001133104.GA21626@atrey.karlin.mff.cuni.cz>
References: <20031001101826.GA3503@elf.ucw.cz> <20031001122412.GJ24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031001122412.GJ24824-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > AFAICS. It also adds some externs to include/linux/acpi.h, but I
> > believe *way* more externs are needed. Please apply,
> 
> > --- /usr/src/tmp/linux/include/linux/acpi.h	2003-08-27 12:00:48.000000000 +0200
> > +++ /usr/src/linux/include/linux/acpi.h	2003-10-01 11:53:51.000000000 +0200
> > @@ -403,8 +403,8 @@
> >  
> >  struct pci_dev;
> >  
> > -int acpi_pci_irq_enable (struct pci_dev *dev);
> > -int acpi_pci_irq_init (void);
> > +extern int acpi_pci_irq_enable (struct pci_dev *dev);
> > +extern int acpi_pci_irq_init (void);
> 
> Why do they need to be externs?  The comp.lang.c FAQ suggests they don't
> have to be.
> 
> http://www.eskimo.com/~scs/C-faq/q1.11.html

Well, they don't *have* to be there, but as FAQ says, it is stylistics
hint.


									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
