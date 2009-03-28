From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: make some IO ports off-limits to AML
Date: Fri, 27 Mar 2009 21:30:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903272127350.26419@localhost.localdomain>
References: <alpine.LFD.2.00.0902032258080.5607@localhost.localdomain>
 <20090204061505.GD28321@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:26677 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757500AbZC1BbA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 21:31:00 -0400
In-reply-to: <20090204061505.GD28321@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 4 Feb 2009, Matthew Garrett wrote:

> On Tue, Feb 03, 2009 at 10:59:43PM -0500, Len Brown wrote:
> 
> > Start using this interface to prevent AML from accessing
> > some well known IO addresses that the OS "owns".
> 
> It might be nice to extend this to cover the other ports listed at 
> http://www.microsoft.com/whdc/archive/BIOSAML.mspx if (and only if) the 
> firmware requested _OSI("Windows 2001") or later.

Right.  We reverted this initialization-time check for 2.6.29
b/c it had false positives of opregions that were never used.

For 2.6.30 we replaced it with a run-time check, and the check
follows the compatibility rules referenced above.

http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commitdiff;h=7f0719039085cc40114abce84cf29fe57da226f4

cheers,
Len Brown, Intel Open Source Technology Center

