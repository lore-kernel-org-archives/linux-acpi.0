From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: 2.6.26.[1-3] + x61 tablet + x6ultrabase: no resume	after?undocking
Date: Wed, 03 Sep 2008 17:04:26 +0200
Message-ID: <48BEA77A.5050104@dbservice.com>
References: <200808301535.22419.sfking@fdwdc.com> <20080901112816.GA21970@khazad-dum.debian.net> <48BBDD2C.5020804@dbservice.com> <200809011205.05253.sfking@fdwdc.com> <20080903144541.GA10978@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dbservice.com ([213.239.204.14]:48830 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754030AbYICPEr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2008 11:04:47 -0400
In-Reply-To: <20080903144541.GA10978@homac>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven King <sfking@fdwdc.com>, Tomas Carnecky <tom@dbservice.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.orglinux-

Holger Macht wrote:
> On Mon 01. Sep - 12:05:04, Steven King wrote:
>> On Monday 01 September 2008 5:16:44 Tomas Carnecky wrote:
>>
>>> I just tested suspend/resume with the CDROM drive removed (an empty
>>> bay). Suspend/resume now works just fine, regardless how I dock/undock
>>> the laptop.
>> I'm seeing the exact same things as Tom.  Also, in my dmesg I see:
>>
>> ACPI: \_SB_.PCI0.IDE0.PRIM.MSTR: found ejectable bay
>> ACPI: \_SB_.PCI0.IDE0.PRIM.MSTR: Adding notify handler
>> ACPI: Error installing bay notify handler
>>
>> is this significant?
> 
> No, it's not. Bay driver is obsolete with 2.6.26's libata hotplug code.
> 

I don't know whether I should ROFL or be sad, but: In the 2.6.26 stable
tree the bay driver (ACPI_BAY) is marked as EXPERIMENTAL, and now you're
saying that it's obsolete. Do features go right from experimental to
obsolete now?

I'll try to disable the bay driver, let's see if that helps any.

tom
