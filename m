From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] Fix up a multitude of ACPI compiler warnings on x86_64
Date: Fri, 29 Sep 2006 16:18:52 -0700
Message-ID: <20060929161852.4b6ae44a.rdunlap@xenotime.net>
References: <451D9236.6040902@google.com>
	<20060929150526.38eec941.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:7116 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932077AbWI2XR1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Sep 2006 19:17:27 -0400
Received: from midway.site ([71.245.102.242]) by xenotime.net for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2006 16:17:25 -0700
In-Reply-To: <20060929150526.38eec941.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Cc: Martin Bligh <mbligh@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Fri, 29 Sep 2006 15:05:26 -0700 Andrew Morton wrote:

> On Fri, 29 Sep 2006 14:37:58 -0700
> Martin Bligh <mbligh@google.com> wrote:
> 
> > 32bit vs 64 bit issues. sizeof(sizeof) and sizeof(pointer) is variable,
> > but we're trying to shove it into unsigned int or u32.
> >
> > ...
> >
> > -	"RSDT/XSDT length (%X) is smaller than minimum (%X)",
> > +	"RSDT/XSDT length (%X) is smaller than minimum (%lX)",
> >  	table_ptr->length,
> > -	sizeof(struct acpi_table_header)));
> > +	(unsigned long) sizeof(struct acpi_table_header)));
> > 
> 
> These two sizeof()s have already been fixed by Randy in -mm's
> acpi-fix-printk-format-warnings.patch.
> 
> Randy's fix is the preferred one: sizeof() returns size_t and size_t's are
> printed with %z - there's no need to use a typecast.
> 
> (Actually Randy used %Z which avoids the warning which old gcc emitted with
> %z, but is old-fashioned.  I'll switch that to %z).
> 
> 
> acpi-fix-printk-format-warnings.patch was submitted to the ACPI developers
> on August 14 and on September 25 but remains unmerged.

Len and I discussed that patch some.  The question about it is:
why does gcc report this at all?  Is this a gcc problem or are
we misreading it somehow?

 drivers/acpi/tables/tbget.c: In function 'acpi_tb_get_this_table':
drivers/acpi/tables/tbget.c:326: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'

drivers/acpi/tables/tbrsdt.c: In function 'acpi_tb_validate_rsdt':
drivers/acpi/tables/tbrsdt.c:189: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'

Why does it think that sizeof(struct X) is long unsigned int?
(and only on 64-bit)

---
~Randy
