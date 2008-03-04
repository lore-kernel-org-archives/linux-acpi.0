From: Bart Samwel <bart@samwel.tk>
Subject: Re: [PATCH 0/5] Laptop driver documentation changes for 2.6.25
Date: Tue, 04 Mar 2008 09:21:36 +0100
Message-ID: <47CD0690.5080009@samwel.tk>
References: <20080209013157.4895.70128.stgit@pacifica>	<20080211112339.31ae3a68.randy.dunlap@oracle.com>	<200802111929.30877.carlos@strangeworlds.co.uk> <20080303142702.33483f97.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from customer-vserver-jkruis-1.all2all.org ([62.58.108.47]:49484
	"EHLO jkruis.all2all.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbYCDIsi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 03:48:38 -0500
In-Reply-To: <20080303142702.33483f97.randy.dunlap@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>

Randy Dunlap wrote:
> On Mon, 11 Feb 2008 19:29:29 +0000 Carlos Corbacho wrote:
> 
>> On Monday 11 February 2008 19:23:39 Randy Dunlap wrote:
>>> On Sat, 09 Feb 2008 01:31:57 +0000 Carlos Corbacho wrote:
>>>> The following series implements the proposed creation of
>>>> Documentation/laptops, and the movement of all the laptop driver
>>>> documentation to this directory. I've also taken the opportunity to tack
>>>> on the acer-wmi documentation in the final patch of this series.
>>>>
>>>> Because all the drivers in question go through the ACPI tree anyway, it's
>>>> probably easiest if this change goes through the ACPI tree as well.
>>>>
>>>> This should all be 2.6.25 material, since there is no code change here,
>>>> just rearranging the Documentation files, and updating Kconfig entries
>>>> where required. I've also tested this series against Linus' latest git
>>>> tree, with no problems applying it there.
>>> Hi,
>>> so should we also move Documentation/laptop-mode.txt to laptops/ dir?
>> [CC'ing Bart Samwel on this, as he wrote Documentation/laptop-mode.txt]
>>
>> Yes, we probably should.
> 
> Hi Bart,
> Is that OK with you?
> if we move laptop-mode.txt to the Documenation/laptops/ sub-directory?

Sounds fine by me!

Cheers,
Bart
