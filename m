From: Mark Lord <lkml@rtr.ca>
Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Mon, 07 Jan 2008 10:07:55 -0500
Message-ID: <4782404B.704@rtr.ca>
References: <20071130142058.816d1693.akpm@linux-foundation.org>	<924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com>	<4750CC78.9070105@rtr.ca>	<20071130190227.1976e682@laptopd505.fenrus.org>	<4750D180.6080001@rtr.ca>	<20071130191816.3e744205@laptopd505.fenrus.org>	<4750D585.1030200@rtr.ca>	<477C2143.8090406@rtr.ca>	<924EFEDD5F540B4284297C4DC59F3DEE4FC485@orsmsx423.amr.corp.intel.com>	<477C622F.6010304@rtr.ca>	<20080104021619.GA15409@linux-os.sc.intel.com>	<47814958.3070208@rtr.ca>	<20080106231848.762e93c1.akpm@linux-foundation.org> <20080107060707.55af6d9c@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2190 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959AbYAGPH4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jan 2008 10:07:56 -0500
In-Reply-To: <20080107060707.55af6d9c@laptopd505.fenrus.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, abelay@novell.com, lenb@kernel.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl

Arjan van de Ven wrote:
..
> if we take a step back; Mark afaics only wants to put 1 in there...
> And that makes sense; either you want the "no latency" C1, or you want the lot
> (esp given that C2 and deeper are at the whim of the bios, what they mean varies
> over time. Actually even C1 does that on some AMD systems);
> 
> Longer term I'd suggest we make an option that basically is "C1 only",
> (or technically, "use hlt only")
> that solves Marks VMWARE thing, and is a lot closer to what people really want.
..

Yeah, that makes sense.

> Well, that and if VMWARE really can't deal with latency in their kernel module
> they should use the proper code for that. It's also a ton easier to implement, since
> it basically is "don't use the CPUIDLE idle loop, but use the traditional hlt one"
..

I don't think it's so much VMware itself, as it is the guest OS inside it.

Cheers

