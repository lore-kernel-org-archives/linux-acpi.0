From: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Tue, 1 Aug 2017 15:21:38 -0400
Message-ID: <b6802e30-cb1e-5fa8-6afc-09b4e05d78c9@gmail.com>
References: <20170626062657.GE4229@linux-l9pv.suse>
 <20170626085907.GE11534@dhcp22.suse.cz>
 <20170711082532.GA6927@dhcp22.suse.cz>
 <20170713065806.GB2901@linux-l9pv.suse>
 <20170713070618.GC14492@dhcp22.suse.cz>
 <20170713124521.GE2901@linux-l9pv.suse>
 <20170714083713.GB2618@dhcp22.suse.cz>
 <20170714144414.GM2901@linux-l9pv.suse>
 <20170723060248.GA3034@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37040 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdHATVl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2017 15:21:41 -0400
In-Reply-To: <20170723060248.GA3034@linux-l9pv.suse>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Michal Hocko <mhocko@kernel.org>

Hi Joey,

On 07/23/2017 05:18 AM, joeyli wrote:
> Hi Yasuaki,  
> 
> On Fri, Jul 14, 2017 at 10:44:14PM +0800, joeyli wrote:
>> On Fri, Jul 14, 2017 at 10:37:13AM +0200, Michal Hocko wrote:
>>> On Thu 13-07-17 20:45:21, Joey Lee wrote:
>>>> On Thu, Jul 13, 2017 at 09:06:19AM +0200, Michal Hocko wrote:
>>>>> On Thu 13-07-17 14:58:06, Joey Lee wrote:
>>> [...]
>>>>>> If BIOS emits ejection event for a ACPI0004 container, someone needs
>>>>>> to handle the offline/eject jobs of container. Either kernel or user
>>>>>> space.
>>>>>>
>>>>>> Only sending uevent to individual child device can simplify udev rule,
>>>>>> but it also means that the kernel needs to offline/eject container
>>>>>> after all children devices are offlined.
>>>>>
>>>>> Why cannot kernel send this eject command to the BIOS if the whole
>>>>> container is offline? If it is not then the kernel would send EBUSY to
>>>>
>>>> Current kernel container hot-remove process:
>>>>
>>>>   BIOS -> SCI event -> Kernel ACPI -> uevent -> userland
>>>>               
>>>> Then, kernel just calls _OST to expose state to BIOS, then process is
>>>> stopped. Kernel doesn't wait there for userland to offline each child
>>>> devices. Either BIOS or userland needs to trigger the container
>>>> ejection.
>>>>
>>>>> container is offline? If it is not then the kernel would send EBUSY to
>>>>> the BIOS and BIOS would have to retry after some timeout. Or is it a
>>>>
>>>> The d429e5c122 patch is merged to mainline. So kernel will send
>>>> DEVICE_BUSY to BIOS after it emits uevent to userland. BIOS can choice
>>>> to apply the retry approach until OS returns process failure exactly or
>>>> BIOS timeout.
>>>>
>>>>> problem that currently implemented BIOS firmwares do not implement this
>>>>> retry?
>>>>
>>>> Yes, we should consider the behavior of old BIOS. Old BIOS doesn't
>>>> retry/resend the ejection event. So kernel or userland need to take the
>>>> retry job. Obviously userland runs the retry since the caa73ea15 patch
>>>> is merged.
>>>>
>>>> IMHO there have two different expectation from user space application.
>>>>
>>>> Applications like DVD player or Burner expect that kernel should
>>>> info userspace for the ejection, then application can do their cleaning
>>>> job and re-trigger ejection from userland.
>>>
>>> I am not sure I understand the DVD example because I do not see how it
>>> fits into the container and online/offline scenario.
>>>
>>
>> At least Yasuaki raised similar behavior for container in 2013.
>> It's similar to the DVD player case, user space application needs
>> to do something then trigger children offline and ejection of
>> container.
>>
>> Base on Yasuaki's explanation, the reason of that he requested the
>> userland ejection approach is that he got memory hot-remove problem
>> in 2013. Maybe his problem is already fixed by your patches in current
>> mainline.
>>
>> Hi Yasuaki, could you please check that your memory hot-remove problem
>> is fixed on mainline kernel?  

I cannot remember what I mentioned in 2013. Could you tell me url of lkml archive.

Thanks,
Yasuaki Ishimatsu

>>
>> If Yasuaki's issue is already fixed, then we should consider to let
>> kernel does the container hot-remove transparently. 
> 
> Could you please help to check that your memory hot-remove problem in 2013
> is fixed on mainline kernel?  
> 
> Thanks a lot!
> Joey Lee
> 
