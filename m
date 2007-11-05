From: Roman Rumisek <romrum@cbox.cz>
Subject: Re: Acpi suspend to ram on Acer Aspire 5672
Date: Mon, 05 Nov 2007 10:27:24 +0100
Message-ID: <fgmnkg$9eu$1@ger.gmane.org>
References: <472847A2.9020901@salfischberger.nl> <fgktis$ra8$1@ger.gmane.org> <472E40DE.4090001@salfischberger.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:39956 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393AbXKEJ0s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Nov 2007 04:26:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IoyEI-0007Ns-DH
	for linux-acpi@vger.kernel.org; Mon, 05 Nov 2007 09:26:46 +0000
Received: from ipn230.customer.medialine.cz ([82.114.206.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 05 Nov 2007 09:26:46 +0000
Received: from romrum by ipn230.customer.medialine.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 05 Nov 2007 09:26:46 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Tomas Salfischberger wrote:

> Hi,
> 
> Roman Rumisek wrote:
>> I have this problem on ACER Extensa 5220.
>> The "save to disk" is OK,but after "save to RAM" the notebook hangs
>> and seems (for example when i press CapsLock key - nothing) one is dead.
>>   
> 
> I also received an off-list reply from Peter Pregler about his Acer TM
> 3200 having the same issues.
> 
> What we need to debug this is some method of first finding out whether
> the kernel-code is actually reached during the resume process. If it is
> actually executing kernel-code, we need to debug at which point in
> hardware initialization it gets stuck.
> 
> Peter mentioned we need serial-port access (or a special firewire-cable)
> to debug. Do you have a docking-station?

No, only notebook.

> 
> An other approach would be to patch the kernel to use the system-speaker
> to output some debug beeps. I'll look into that the next moment I have a
> few spare hours, probably Thursday.
> 
> Just to get more details: Is the "Acer Extensa 5220" a dual core model?

May be, but I have notebook with D530 Celeron.

Roman


> 
> Thanks for your reply,
> 
> Tomas
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


