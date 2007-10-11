From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 3/6] PNP: use dev_info(), dev_err(), etc in core
Date: Thu, 11 Oct 2007 14:32:11 -0600
Message-ID: <200710111432.12159.bjorn.helgaas@hp.com>
References: <20070928163911.697537922@ldl.fc.hp.com> <20070928164350.079891622@ldl.fc.hp.com> <20071010224739.f4ecd5aa.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:36367 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348AbXJKVAo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Oct 2007 17:00:44 -0400
In-Reply-To: <20071010224739.f4ecd5aa.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

On Wednesday 10 October 2007 11:47:39 pm Andrew Morton wrote:
> On Fri, 28 Sep 2007 10:39:14 -0600 Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> 
> > --- w.orig/include/linux/pnp.h	2007-09-13 16:25:48.000000000 -0600
> > +++ w/include/linux/pnp.h	2007-09-13 16:26:04.000000000 -0600
> > @@ -8,6 +8,10 @@
> >  
> >  #ifdef __KERNEL__
> >  
> > +#ifdef CONFIG_PNP_DEBUG
> > +#define DEBUG
> > +#endif
> 
> In file included from include/linux/isapnp.h:26,
>                  from drivers/pcmcia/i82365.c:58:
> include/linux/pnp.h:12:1: warning: "DEBUG" redefined
> <command line>:1:1: warning: this is the location of the previous definition
> 
> testing problems?

I didn't use the correct idiom for turning on DEBUG, and I didn't
built with allyesconfig (sorry), so didn't notice.  Can you add the
patch below, please?



PNP: turn on -DDEBUG when CONFIG_PNP_DEBUG is enabled

We now use dev_dbg(), which is enabled when DEBUG is defined.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: w/drivers/pnp/Makefile
===================================================================
--- w.orig/drivers/pnp/Makefile	2007-10-11 08:59:13.000000000 -0600
+++ w/drivers/pnp/Makefile	2007-10-11 09:04:46.000000000 -0600
@@ -7,3 +7,7 @@
 obj-$(CONFIG_PNPACPI)		+= pnpacpi/
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
+
+ifeq ($(CONFIG_PNP_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
