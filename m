From: Roman Zippel <zippel@linux-m68k.org>
Subject: RE: [PATCH] [2.6.13-mm2] set IBM ThinkPad extras to default n in
 Kconfig
Date: Fri, 9 Sep 2005 18:25:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0509091817220.3743@scrub.home>
References: <F7DC2337C7631D4386A2DF6E8FB22B30048FA292@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030218AbVIIQZp@vger.kernel.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30048FA292@hdsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, Borislav Petkov <petkov@uni-muenster.de>, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Fri, 9 Sep 2005, Brown, Len wrote:

> >--- drivers/acpi/Kconfig.orig	2005-09-09 09:46:26.000000000 +0200
> >+++ drivers/acpi/Kconfig	2005-09-09 09:46:46.000000000 +0200
> >@@ -197,7 +197,7 @@ config ACPI_ASUS
> > config ACPI_IBM
> > 	tristate "IBM ThinkPad Laptop Extras"
> > 	depends on X86
> >-	default y
> >+	default n
> > 	---help---
> > 	  This is a Linux ACPI driver for the IBM ThinkPad 
> 
> Before we had "default m", since that is how a distro
> is expected to compile this, and other, "ACPI drivers".
> 
> But we got complaits that _nothing_ should be "default m",
> so I changed it to "default y".  Maybe that was simplistic --
> button should be "default y", but the platform drivers should
> all be "default n"?
> 
> I'm not sure what to do here -- what use-model
> should we tune default Kconfig for?

The best would be to avoid using defaults completely, unless the resulting 
kernel is non-functional (e.g. it doesn't compile or boot).
So far it's still the responsibility of the user to explicitly turn 
everything on he needs (at least until we have a functional autoconfig).
BTW distros are not the only users, from them I would expect how to 
configure a kernel.

bye, Roman
