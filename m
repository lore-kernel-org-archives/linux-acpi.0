From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA release 20110211 linuxized patches
Date: Fri, 18 Mar 2011 18:01:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103181756470.24304@x980>
References: <1297672276.21742.21.camel@minggr.sh.intel.com>
 <1300414593.29989.2.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:57555 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932848Ab1CRWBa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2011 18:01:30 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LI900I19X63WLM8@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 18 Mar 2011 17:01:30 -0500 (CDT)
In-reply-to: <1300414593.29989.2.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

> Did you push these patches out to the linux-acpi-2.6.git repository?

yes, the've been on the acpica branch for about a month,
though strangely I don't see that branch updated on kernel.org...
will fix now.

cheers,
-Len

> Lin Ming
> 
> On Mon, 2011-02-14 at 16:31 +0800, Lin Ming wrote:
> > Hi, Len
> > 
> > ACPICA release 20110211 linuxized patches attached.
> > Applied cleanly on top of Linus tree(091994cf) and tested on my
> > notebook.
> > 
> > [PATCH 1/9] ACPICA: GPE detect optimization - ignore unused GPE registers
> > [PATCH 2/9] ACPICA: Remove use of unreliable FADT revision field
> > [PATCH 3/9] ACPICA: Clarify a couple of error messages
> > [PATCH 4/9] ACPICA: Split large utglobal into utdecode.c.
> > [PATCH 5/9] ACPICA: Fix unresolved name issue for no-debug and no-error-msg cases
> > [PATCH 6/9] ACPICA: Split large dsopcode and dsload.c files.
> > [PATCH 7/9] ACPICA: Add support for FunctionalFixedHW in acpi_ut_get_region_name
> > [PATCH 8/9] ACPICA: Add mechanism to defer _REG methods for some installed handlers
> > [PATCH 9/9] ACPICA: Update version to 20110211.
> > 
> > Lin Ming
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
