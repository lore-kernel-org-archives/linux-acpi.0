From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/8] ACPI: ACPI table management enhencement
Date: Mon, 05 Jan 2009 16:04:12 +0800
Message-ID: <1231142652.32473.43.camel@rzhang-dt>
References: <1229673457.562.132.camel@rzhang-dt>
	 <alpine.LFD.2.00.0812311856520.3854@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57115 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbZAEICy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Jan 2009 03:02:54 -0500
In-Reply-To: <alpine.LFD.2.00.0812311856520.3854@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Thu, 2009-01-01 at 07:58 +0800, Len Brown wrote:
> On Fri, 19 Dec 2008, Zhang Rui wrote:
> 
> > Hi all,
> > 
> > this patch set is an ACPI table management enhancement.
> > 
> > Patch 01 adds the new sysfs I/F for ACPI dynamic tables.
> > now dynamic ACPI tables can be get at
> > /sys/firmware/acpi/tables/dynamic/...
> > 
> > Patch 02 ~ 08 introduce the ACPI inactive table management.
> > Here inactive table means the table that is pointed to by
> > the inactive root table, e.g RSDT if Linux is using XSDT.
> > Detailed introduction of each patch is in the change log.
> 
> I recall trying out a previous version of this series,
> and I'd like to try out this version, but I'm having
> trouble getting it to apply.  What tree is it based on?
the patch set is based on the ACPI test tree.
and it still applies to the current test tree cleanly.

> (2.6.28 would be a good choice, or the acpica branch)
> 
Okay. this patch set touches a lot of the ACPICA code.
And in fact, I'd prefer to refresh it on the ACPI release branch,
i.e. refresh them after you have fixed the conflicts between the ACPICA
branch and test branch. what do you think?

thanks,
rui

