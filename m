From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ACPI pci irq routing fix
Date: 30 Sep 2003 01:17:22 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1064899042.2532.101.camel@dhcppc4>
References: <20030926182128.C24360@osdlab.pdx.osdl.net>
	 <3F752619.5000406@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3F752619.5000406-/x7JMgtu12E0n/F98K4Iww@public.gmane.org>
To: Nick Piggin <piggin-/x7JMgtu12E0n/F98K4Iww@public.gmane.org>
Cc: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2003-09-27 at 01:54, Nick Piggin wrote:
> Chris Wright wrote:
> 
> >If irq.active is set from _CRS, make sure to use it
...
> and fixes bug #1186.
> >
> >Patch originally from Andrew de Quincey.
> >
> 
> This fixes my bug #1257.
> 

This fix has been integrated with others in the ACPI patch,
and is available now in these bitkeeper trees:

http://linux-acpi.bkbits.net/linux-acpi-test-2.4.22
http://linux-acpi.bkbits.net/linux-acpi-test-2.4.23
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.0

It is also available as a plain patch "acpi_pci_link_allocate" here:

ftp.kernel.org:/pub/linux/kernel/people/lenb/acpi/patches/test/*

thanks,
-Len
