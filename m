From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Tue, 02 Apr 2013 18:53:05 +0200
Message-ID: <515B0CF1.20900@fold.natur.cuni.cz>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com> <51548C9E.9090703@fold.natur.cuni.cz> <2990024.LMTIBUbM3d@vostro.rjw.lan> <51564804.9000700@fold.natur.cuni.cz> <CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com> <515AF312.1010507@fold.natur.cuni.cz> <CAC=cRTM6pMJ1Ujp9vs0DBwA4p_0C9LTcDm0y=w5wbf-R-JF68w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:35820 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759798Ab3DBQxJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Apr 2013 12:53:09 -0400
In-Reply-To: <CAC=cRTM6pMJ1Ujp9vs0DBwA4p_0C9LTcDm0y=w5wbf-R-JF68w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: huang ying <huang.ying.caritas@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>



huang ying wrote:
> Hi, Martin,
> 
> Thanks for your test!
> 
> On Tue, Apr 2, 2013 at 11:02 PM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
>> Hi Ying,
>>
>> huang ying wrote:
>>> Hi, Martin,
>>>
>>> On Sat, Mar 30, 2013 at 10:03 AM, Martin Mokrejs
>>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>>> Rafael J. Wysocki wrote:
>>
>>>>> If it doesn't make all of them go away, does it make *some* of them go away?
>>>>
>>>> Yes, repeated inserts and removals of devices into xHCI slot work fine, no need
>>>> to use "lsusb -vv" to wakeup devices.
>>>>
>>>> Aside from some minor USB errors (won't mess them here) what is important is the fact
>>>> that the eSATA card hotplug works well or perfectly. I just sent to you and other pci devs
>>>> much more detailed report under the "Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI"
>>>> thread although this particular testing was done on 3.8.3.
>>>>
>>>> I think I can stop replying to this thread which is about the patch from Sarah.
>>>> My dead XHCI port issue is a power management issue, incidentally also fixed by the
>>>> very same patch from Huang Ying. Cool! ;-)
>>>
>>> Sorry, which patch do you mean?  Or to be more clear, could you test
>>> the patch attached? For the XHCI dead port issue?
>>
>> So I tested your port_dbg.patch on 3.8.3. Or did you want me to do it on 3.8.5?
> 
> I think that is OK.  Although my patch is against 3.9-rc4.
> 
> I don't know why, but it appears that there is no any debug messages
> that my patch will print in your dmesg.  For example, in my patch, if
> the PCIe port (1c.4) goes into suspended, there should be something as
> follow in the dmesg:
> 
> pcieport 0000:00:1c.4: ppri: will go suspend, is_hotplug_bridge: <0 or 1>
> 
> Are you sure you send me the right dmesg?  Or you use the right patch or kernel?

Damn you are right, I forgot to apply it. Consider what I reported as vanilla 3.8.3
behavior.

So it applies over 3.8.3 proving I forgot to run the patch command. :((

OK, will redo it with 3.8.5 so we stay close to 3.8.2 where I initially reported
the xHCI dead port issue. And will open a bug at bugzilla.kernel.org.


Martin
P.S.: Per Rafael's request in another thread at http://marc.info/?l=linux-pm&m=136491301104336&w=2
we might bring something from that back into linux-pci/acpi. Meanwhile, take that as a brief note
how things are on 3.9-rc5.
