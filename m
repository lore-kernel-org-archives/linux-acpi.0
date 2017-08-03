From: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Subject: Re: A udev rule to serve the change event of ACPI container?
Date: Thu, 3 Aug 2017 11:37:37 -0400
Message-ID: <8c04a96f-3f7a-1c31-9522-3344a4751d33@gmail.com>
References: <20170626062657.GE4229@linux-l9pv.suse>
 <20170626085907.GE11534@dhcp22.suse.cz>
 <20170711082532.GA6927@dhcp22.suse.cz>
 <20170713065806.GB2901@linux-l9pv.suse>
 <20170713070618.GC14492@dhcp22.suse.cz>
 <20170713124521.GE2901@linux-l9pv.suse>
 <20170714083713.GB2618@dhcp22.suse.cz>
 <20170714144414.GM2901@linux-l9pv.suse>
 <20170723060248.GA3034@linux-l9pv.suse>
 <b6802e30-cb1e-5fa8-6afc-09b4e05d78c9@gmail.com>
 <20170802054939.GL2946@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33879 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbdHCPhk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2017 11:37:40 -0400
In-Reply-To: <20170802054939.GL2946@linux-l9pv.suse>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Michal Hocko <mhocko@kernel.org>, yasu.isimatu@gmail.com



On 08/02/2017 01:49 AM, joeyli wrote:
> Hi YASUAKI,
> 
> On Tue, Aug 01, 2017 at 03:21:38PM -0400, YASUAKI ISHIMATSU wrote:
>> Hi Joey,
>>
>> On 07/23/2017 05:18 AM, joeyli wrote:
> [...snip]
>>>>>
>>>>
>>>> At least Yasuaki raised similar behavior for container in 2013.
>>>> It's similar to the DVD player case, user space application needs
>>>> to do something then trigger children offline and ejection of
>>>> container.
>>>>
>>>> Base on Yasuaki's explanation, the reason of that he requested the
>>>> userland ejection approach is that he got memory hot-remove problem
>>>> in 2013. Maybe his problem is already fixed by your patches in current
>>>> mainline.
>>>>
>>>> Hi Yasuaki, could you please check that your memory hot-remove problem
>>>> is fixed on mainline kernel?  
>>
>> I cannot remember what I mentioned in 2013. Could you tell me url of lkml archive.
>>
> 

> Here: https://lkml.org/lkml/2013/11/28/520

Thank you for specifying the URL. In the URL, I wrote the following problems:

>   1. easily fail
>      My container device has CPU device and Memory device, and maximum size of
>      memory is 3Tbyte. In my environment, hot removing container device fails
>      on offlining memory if memory is used by application.
>      I think if offlininig memory, we must retly to offline memory several
>      times.

I think the issue still remains. If process keeps accessing memory, offlining
the memory easily fails with EBUSY.

Thanks,
Yasuaki Ishimatsu


> 
> In the mail, you mentioned two problems. But there have no detail about
> those issues, and no root causes. We don't know why kernel should relies
> on user space to complete the hot removing process for container.
> 
> Thank a lot!
> Joey Lee
> 
