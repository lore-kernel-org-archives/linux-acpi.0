From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] Add a passive cooling trip point if the firmware doesn't define one
Date: Thu, 15 May 2008 03:24:31 +0100
Message-ID: <20080515022431.GA15085@srcf.ucam.org>
References: <20080514010000.GB21608@srcf.ucam.org> <20080514010300.GC21608@srcf.ucam.org> <20080514010820.GD21608@srcf.ucam.org> <200805132330.20159.lenb@kernel.org> <20080514093304.GB28678@srcf.ucam.org> <1210812916.2929.6.camel@rzhang-crestline.sh.intel.com> <20080515010426.GA13927@srcf.ucam.org> <1210814699.2929.10.camel@rzhang-crestline.sh.intel.com> <20080515015831.GA14829@srcf.ucam.org> <1210817739.2929.24.camel@rzhang-crestline.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51502 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbYEOCY4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 May 2008 22:24:56 -0400
Content-Disposition: inline
In-Reply-To: <1210817739.2929.24.camel@rzhang-crestline.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Thu, May 15, 2008 at 10:15:39AM +0800, Zhang Rui wrote:
> On Thu, 2008-05-15 at 02:58 +0100, Matthew Garrett wrote:
> > I'll modify my patch so it uses the devices in a _TZD package if they're 
> > present.
> > 
> Hmm, ACPI thermal zone doesn't know how to throttle the devices in a
> _TZD package, so I don't think we can use the _TZD devices.

If they have a _TZD, it's presumably because they need cooling. If the 
kernel isn't going to be able to do that, what happens if the userspace 
daemon crashes or fails to start for some reason? 

The alternative is to leave it as it is currently in my patch. If the 
userspace daemon starts, it disables the ACPI control and will handle it 
itself. If it doesn't start, the kernel does the only thing it can - 
reduce the speed of the CPU. If there are no plans to add hooks for the 
drivers to be throttled by the kernel, then I'd argue that this is the 
right thing to do.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
