From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Wed, 3 Apr 2013 00:08:54 +0800
Message-ID: <CAC=cRTM6pMJ1Ujp9vs0DBwA4p_0C9LTcDm0y=w5wbf-R-JF68w@mail.gmail.com>
References: <2282655.IicBMMa6jN@vostro.rjw.lan>
	<CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com>
	<51548C9E.9090703@fold.natur.cuni.cz>
	<2990024.LMTIBUbM3d@vostro.rjw.lan>
	<51564804.9000700@fold.natur.cuni.cz>
	<CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com>
	<515AF312.1010507@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:51253 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761427Ab3DBQIz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Apr 2013 12:08:55 -0400
Received: by mail-bk0-f53.google.com with SMTP id e19so301624bku.26
        for <linux-acpi@vger.kernel.org>; Tue, 02 Apr 2013 09:08:54 -0700 (PDT)
In-Reply-To: <515AF312.1010507@fold.natur.cuni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

Hi, Martin,

Thanks for your test!

On Tue, Apr 2, 2013 at 11:02 PM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> Hi Ying,
>
> huang ying wrote:
>> Hi, Martin,
>>
>> On Sat, Mar 30, 2013 at 10:03 AM, Martin Mokrejs
>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>> Rafael J. Wysocki wrote:
>
>>>> If it doesn't make all of them go away, does it make *some* of them go away?
>>>
>>> Yes, repeated inserts and removals of devices into xHCI slot work fine, no need
>>> to use "lsusb -vv" to wakeup devices.
>>>
>>> Aside from some minor USB errors (won't mess them here) what is important is the fact
>>> that the eSATA card hotplug works well or perfectly. I just sent to you and other pci devs
>>> much more detailed report under the "Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI"
>>> thread although this particular testing was done on 3.8.3.
>>>
>>> I think I can stop replying to this thread which is about the patch from Sarah.
>>> My dead XHCI port issue is a power management issue, incidentally also fixed by the
>>> very same patch from Huang Ying. Cool! ;-)
>>
>> Sorry, which patch do you mean?  Or to be more clear, could you test
>> the patch attached? For the XHCI dead port issue?
>
> So I tested your port_dbg.patch on 3.8.3. Or did you want me to do it on 3.8.5?

I think that is OK.  Although my patch is against 3.9-rc4.

I don't know why, but it appears that there is no any debug messages
that my patch will print in your dmesg.  For example, in my patch, if
the PCIe port (1c.4) goes into suspended, there should be something as
follow in the dmesg:

pcieport 0000:00:1c.4: ppri: will go suspend, is_hotplug_bridge: <0 or 1>

Are you sure you send me the right dmesg?  Or you use the right patch or kernel?

Best Regards,
Huang Ying
