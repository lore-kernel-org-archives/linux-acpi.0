From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] ACPI : Disable the C2C3_FFH access mode if MWAIT is
	unsupported
Date: Thu, 05 Jun 2008 13:45:27 +0800
Message-ID: <1212644727.14847.1.camel@sli10-desk.sh.intel.com>
References: <1212637455.10730.8.camel@yakui_zhao.sh.intel.com>
	 <alpine.LFD.1.10.0806050130220.4914@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52939 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbYFEFkL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Jun 2008 01:40:11 -0400
In-Reply-To: <alpine.LFD.1.10.0806050130220.4914@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org

On Thu, 2008-06-05 at 13:35 +0800, Len Brown wrote:
> 
> 
> On Thu, 5 Jun 2008, Zhao Yakui wrote:
> 
> > Subject: ACPI: Disable the C2C3_FFH access mode if MWAIT is
> unsupported
> > From: Zhao Yakui <yakui.zhao@intel.com>
> >
> >    After the following commit is merged, C2C3_FFH mode will be
> enabled and
> > passed into the _PDC object. But because MWAIT is unsupported on
> some laptops,
> > the different power states will be returned by the _CST object.
> > Maybe it will be better to disable C2C3_FFH access mode if MWAIT is
> unsupported.
> > 
> > commit 991528d7348667924176f3e29addea0675298944
> > Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > Date:   Mon Sep 25 16:28:13 2006 -0700
> >
> >     ACPI: Processor native C-states using MWAIT
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=10807
> 
> Interesting bug report.
> Unfortunately, it is a BIOS bug that the BIOS exposes C3
> when the OS doesn't support MWAIT, but neglects to expose
> C3 when the OS does support MWAIT.
> 
> This patch will have no effect on the system in the bug report.
> Indeed, it would benefit only a system with a BIOS that thinks
> it has MWAIT support but a CPU that thinks it doesn't...
> 
> probably good hygine to do this, but I don't think it will
> help anything.
> 
> I think the fix for the machine in bug 10807 is to
> have a bootparam that disables mwait support,
> say "idle=!mwait" and a DMI entry for that box
> that invokes it to work around the BIOS bug.
The patch isn't related to the bug, but we got the idea when debugging
the bug. Yakui should write a new description which doesn't mention the
bugzilla. I thought we need this patch to avoid buggy BIOS.

Thanks,
Shaohua

