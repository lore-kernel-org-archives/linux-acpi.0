From: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Subject: RE: [E1000-devel] 2.6.24-rc8-mm1
Date: Thu, 17 Jan 2008 11:47:35 -0800
Message-ID: <36D9DB17C6DE9E40B059440DB8D95F5204368270@orsmsx418.amr.corp.intel.com>
References: <20080117023514.9df393cf.akpm@linux-foundation.org><20080117124622.GA18450@balbir.in.ibm.com><20080117104021.25a8e562.akpm@linux-foundation.org><924EFEDD5F540B4284297C4DC59F3DEE5E909A@orsmsx423.amr.corp.intel.com> <20080117114032.1f9f1df5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21947 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbYAQTrh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2008 14:47:37 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20080117114032.1f9f1df5.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Intel E/100 mailing list <e1000-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org, Linux ACPI mailing list <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, balbir@linux.vnet.ibm.com

Andrew Morton wrote:
> On Thu, 17 Jan 2008 11:22:19 -0800 "Pallipadi, Venkatesh"
> <venkatesh.pallipadi@intel.com> wrote: 
> 
>> 
>> The problem is
>>>> modprobe:2584 conflicting cache attribute 50000000-50001000
>>>> uncached<->default
>> 
>> Some address range here is being mapped with conflicting types.
>> Somewhere the range was mapped with default (write-back). Later
>> pci_iomap() is mapping that region as uncacheable which is basically
>> aliasing. PAT code detects the aliasing and fails the second
>> uncacheable request which leads in the failure.

its probably the e100 screaming interrupt disable quirk code doing the
mapping?
 
> It sounds to me like you need considerably more runtime debugging and
> reporting support in that code.  Ensure that it generates enough
> output 
> both during regular operation and during failures for you to be able
> to 
> diagnose things in a single iteration.
> 
> We can always take it out later.

FWIW (nothing) I agree.
