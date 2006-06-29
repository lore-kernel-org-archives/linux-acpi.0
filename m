From: Rathgeb Markus <maggu2810@web.de>
Subject: Re: amd64 brightness has lowest value after boot
Date: Thu, 29 Jun 2006 09:14:47 +0000
Message-ID: <44A39A07.20408@web.de>
References: <449FBAC8.1060509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:34688 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1751624AbWF2HPX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Jun 2006 03:15:23 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id AFD8253C548
	for <linux-acpi@vger.kernel.org>; Thu, 29 Jun 2006 09:15:22 +0200 (CEST)
Received: from [84.157.215.45] (helo=[192.168.0.100])
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.107 #114)
	id 1FvqkE-0005Qb-00
	for linux-acpi@vger.kernel.org; Thu, 29 Jun 2006 09:15:22 +0200
In-Reply-To: <449FBAC8.1060509@web.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!
I find out (via acpi debug) that this are the execution methods:
decrease brightness: \_SB_.PCI0.EC__._Q12
increase brightness: \_SB_.PCI0.EC__._Q13

Can i execute this methods from hand? whitout press the keys?

Rathgeb Markus wrote:
> Hi!
> I have read the mailinglist for over a year and never heard about a
> similar problem till last month. But there was no answer given.
> If i use a 32 BIT linux the problem DO NOT occur, but for a few month I
> have changed again to a 64 bit linux system (I used 64 bit a year before
> and there was the same problem).
> Everytime after the message "Booting the Kernel" (all versions I
> prepared till 2.6.16) the displays brightness changes to the
> lowest value, so I have to press the hotkeys till the brightness has an
> acceptable value. (this also happens by an ordinary boot without resume.
> I notice that because in the attached email the person writes "My
> problem is that after resume".)
>>From time to time the hotkeys "are confused" (or do not work), too. I
> press the key to
> increase the value and it go hell, dark, hell, hell, dark etc. (it does
> what it want *g*).
> Please help me ;-)
> and excuse my english.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

