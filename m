From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 01/15] ACPI: create kernel/acpi/
Date: Fri, 02 Jan 2009 16:30:36 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901021616590.3590@localhost.localdomain>
References: <1230720725-9376-1-git-send-email-lenb@kernel.org>
 <526647e1bb69fd3248558fce365bb1fbfb226ccd.1230719795.git.len.brown@intel.com>
 <20081231133901.GB2388@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:59795 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbZABVaz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jan 2009 16:30:55 -0500
In-reply-to: <20081231133901.GB2388@uranus.ravnborg.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


On Wed, 31 Dec 2008, Sam Ravnborg wrote:

> > diff --git a/kernel/acpi/Makefile b/kernel/acpi/Makefile
> > new file mode 100644
> > index 0000000..92a1f94
> > --- /dev/null
> > +++ b/kernel/acpi/Makefile
> > @@ -0,0 +1,26 @@
> > +#
> > +# Makefile for the Linux/ACPI
> > +#
> > +
> > +export ACPI_CFLAGS
> > +
> 
> Why is ACPI_CFLAGS exported?

Dunno what export actually does -- drivers/acpi/Makefile
has been this way for many years.

I believe that -Os is the right way to build the ACPI code.

I see that src/Makefile now has

ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
KBUILD_CFLAGS   += -Os
else
KBUILD_CFLAGS   += -O2
endif

so maybe we are now being redundant?

> > +ACPI_CFLAGS	:= -Os
> > +
> > +ifdef CONFIG_ACPI_DEBUG
> > +  ACPI_CFLAGS	+= -DACPI_DEBUG_OUTPUT
> > +endif
> > +
> > +EXTRA_CFLAGS	+= $(ACPI_CFLAGS)

> A better way:
> 
> ccflags-$(CONFIG_ACPI_DEBUG) := -DACPI_DEBUG_OUTPUT
> 
> Note: EXTRA_CFLAGS is deprecated in favour of ccflags-y.

can do.

thanks,
Len Brown, Intel Open Source Technology Center

