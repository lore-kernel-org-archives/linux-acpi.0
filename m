From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Sun, 31 Mar 2013 04:29:12 +0200
Message-ID: <51579F78.7060801@fold.natur.cuni.cz>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com> <51548C9E.9090703@fold.natur.cuni.cz> <2990024.LMTIBUbM3d@vostro.rjw.lan> <CAC=cRTPOOmnkZvM+3Kw4FU79paEhyh-M9vXU4cGoEkN7niH7Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:48095 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755406Ab3CaC3Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Mar 2013 22:29:16 -0400
In-Reply-To: <CAC=cRTPOOmnkZvM+3Kw4FU79paEhyh-M9vXU4cGoEkN7niH7Eg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: huang ying <huang.ying.caritas@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>



huang ying wrote:
> On Fri, Mar 29, 2013 at 5:27 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> On Thursday, March 28, 2013 07:31:58 PM Martin Mokrejs wrote:
>>> Hi Bjorn,
>>>
>>> Bjorn Helgaas wrote:
>>>> On Thu, Mar 28, 2013 at 11:26 AM, Martin Mokrejs
>>>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>>>>
>>>>>
>>>>> Rafael J. Wysocki wrote:
>>>>>> On Thursday, March 28, 2013 10:46:10 AM Bjorn Helgaas wrote:
>>>>>>> On Thu, Mar 28, 2013 at 10:41 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>>>>>>> On Thursday, March 28, 2013 10:21:30 AM Bjorn Helgaas wrote:
>>>>>>>>> On Thu, Mar 28, 2013 at 6:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>>>>>>>>> Hi Bjorn,
>>>>>>>>>>
>>>>>>>>>> I wonder what you think about the patch below?
>>>>>>>>>
>>>>>>>>> Seems fine to me (I'm trusting your and Matthew's judgment here since
>>>>>>>>> I don't know much about it).  Why don't you resend it with Matthew's
>>>>>>>>> ack and the appropriate stable tags, and I'll put it in.
>>>>>>>>
>>>>>>>> I will, thanks!
>>>>>>>>
>>>>>>>>> If you have
>>>>>>>>> a URL for a bugzilla or mailing list report of the original problem,
>>>>>>>>> that would be good, too.  It'd be nice if users and distros could
>>>>>>>>> match problem reports with this solution, but I can't tell what the
>>>>>>>>> user-visible issue was.  I assume that Sarah tested this (or somebody
>>>>>>>>> else reproduced the problem and tested the fix)?
>>>>>>>>
>>>>>>>> Sarah reported it to me privately and I'm afraid I don't have any pointers
>>>>>>>> to publicly available mailing list archives etc.
>>>>>>>
>>>>>>> Do you at least have a description of how a user could determine
>>>>>>> whether he is seeing the problem fixed by this patch?
>>>>>>
>>>>>> Yeah.  For example, when the problem is visible on a USB controller and that
>>>>>> controller is runtime-suspended, then plugging a new USB device into one
>>>>>> of the controller's ports won't wake the controller up without the patch.
>>>>>
>>>>> Hi,
>>>>>  I am wondering for a week or two why nobody answered any of my bug reports,
>>>>> not even Sarah who asked for more details. I am think the fix is about my report
>>>>> under thread "Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled"
>>>>> and I really wonder why I wasn't Cc:ed and listed as a reporter provided it is
>>>>> about my report. But I should better wait what Sarah says. ;-)
> 
> Hi, Martin,
> 
> Sorry for late.  Just found your bug report.  That seems related with
> PCIe port runtime PM support.
> 
> Can you try the debug patch attached?  And send me back the dmesg?
> 
> Sorry I use gmail web client, so I can only send patch as attachment.
> 
> Best Regards,
> Huang Ying
> 

Hi Ying,
  sorry I did not get yet to test this patch (sent on 03/29/13 08:41)?. Is it superseded
by either of your two latter patches?

Second sent on 03/29/13 09:20.

Third sent on 03/30/13 11:54 I did test few hours ago, just have to sum up the
results.

Thank you,
Martin

