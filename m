From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Intel-gfx] [RFC] i915/acpi: add lid status notification and
	detection
Date: Fri, 22 May 2009 02:26:11 +0100
Message-ID: <20090522012611.GA3136@srcf.ucam.org>
References: <20090513115734.338b7d55@jbarnes-g45> <1242264144.3773.415.camel@localhost.localdomain> <20090519171545.GA17801@srcf.ucam.org> <1242896273.32574.10.camel@rzhang-dt> <20090521093418.3f1a03d5@jbarnes-g45> <4A15FE57.7040002@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36217 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZEVB0P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2009 21:26:15 -0400
Content-Disposition: inline
In-Reply-To: <4A15FE57.7040002@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fu Michael <michael_fu@linux.intel.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Zhang Rui <rui.zhang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, lenb@kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, May 22, 2009 at 09:22:31AM +0800, Fu Michael wrote:
> Jesse Barnes wrote:
>> So is that two acks for the patch?  If so, should it be split or can it
>> just go in through the i915 driver tree?
>>
>> Len?  (Patch attached for reference.)
>>
>> Thanks,
>>   
> Jesse, Just talked with Rui,  the above status is based on "BIOS upgrade  
> or FW fix is acceptable as a bug fix solution". are you ok with this? :)  
> Many lid status has to be fixed via action such as DSDT upgrade...

Really? As I said, I'd be surprised if this is in any way common. What's 
the exact problem description?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
