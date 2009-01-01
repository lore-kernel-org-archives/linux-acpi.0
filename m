From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 2.6.28-rc6] ACPICA: don't cond_resched() when   irqs_disabled()
Date: Thu, 01 Jan 2009 13:39:46 -0600
Message-ID: <495D1C02.7080003@shaw.ca>
References: <20081126135508.GA1891@localhost> <alpine.LFD.2.00.0812190016120.6312@localhost.localdomain> <1229670120.3990.11.camel@yakui_zhao.sh.intel.com> <alpine.LFD.2.00.0812190326000.6312@localhost.localdomain> <20081219135147.GA16488@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41663 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbZAATkB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jan 2009 14:40:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LITOe-0005GF-EC
	for linux-acpi@vger.kernel.org; Thu, 01 Jan 2009 19:39:56 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 01 Jan 2009 19:39:56 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 01 Jan 2009 19:39:56 +0000
In-Reply-To: <20081219135147.GA16488@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>

Wu Fengguang wrote:
> On Fri, Dec 19, 2008 at 10:38:18AM +0200, Len Brown wrote:
>>>     The issue on Fengguang's laptop is different with that on the box of
>>> T61.  On Fengguang's laptop after evaluating one ACPI object(GPE
>>> _L18object), the irq is disabled mystically. After some investigations
>>> we find that it is caused by SMI(The SMI will be triggered while
>>> evaluating the ACPI object. And this issue is also related with Video). 
>> Interesting.
>> I hadn't realized you root-caused that failure.
>> This is good to know, but the fact that SMM can
>> leave interrupts disabled is frightening.
> 
>> If the BIOS SMM on that box disables interrupts when
>> random AML is run, then it is going to run into
>> all kinds of other problems in addition to this one...
> 
> Exactly. This is another warning:
> 
> [ 6559.754331] irq status before SMI: enable
> [ 6559.757388] irq status after SMI: disable, value: 0xF3
> [ 6599.816127] Corrupted low memory at ffff88000000fe08 (fe08 phys) = 01007062
> [ 6599.816253] Corrupted low memory at ffff88000000fe10 (fe10 phys) = 7ba83066
> [ 6599.816376] Corrupted low memory at ffff88000000fe18 (fe18 phys) = 00010062
> [ 6599.816492] Corrupted low memory at ffff88000000fe20 (fe20 phys) = 01006062
> [ 6599.816608] Corrupted low memory at ffff88000000fe28 (fe28 phys) = 1000000000
> [ 6599.816724] Corrupted low memory at ffff88000000fe38 (fe38 phys) = 00000ff0
> [ 6599.816840] Corrupted low memory at ffff88000000fe40 (fe40 phys) = 000006e0
> [ 6599.816955] Corrupted low memory at ffff88000000fe48 (fe48 phys) = 880000000000
> [ 6599.817102] Corrupted low memory at ffff88000000fe50 (fe50 phys) = fffffcf930018

(snip)

There is a blacklist at arch/x86/kernel/setup.c for BIOS identifiers 
that may corrupt low memory, in this case the low memory usage is 
minimized. This machine should likely be added to that list.

Might be that Linux and the BIOS stomping on this memory in combination 
is related to some of the other problems seen as well..

These BIOS authors really need to be beaten with a stick though.. they 
can't be using this memory without properly marking it as reserved in 
E820 tables.

