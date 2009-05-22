From: Fu Michael <michael_fu@linux.intel.com>
Subject: Re: [Intel-gfx] [RFC] i915/acpi: add lid status notification and
 detection
Date: Fri, 22 May 2009 09:22:31 +0800
Message-ID: <4A15FE57.7040002@linux.intel.com>
References: <20090513115734.338b7d55@jbarnes-g45>	<1242264144.3773.415.camel@localhost.localdomain>	<20090519171545.GA17801@srcf.ucam.org>	<1242896273.32574.10.camel@rzhang-dt> <20090521093418.3f1a03d5@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:18210 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750797AbZEVBWb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2009 21:22:31 -0400
In-Reply-To: <20090521093418.3f1a03d5@jbarnes-g45>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, lenb@kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Jesse Barnes wrote:
> On Thu, 21 May 2009 16:57:53 +0800
> Zhang Rui <rui.zhang@intel.com> wrote:
>
>   
>> On Wed, 2009-05-20 at 01:15 +0800, Matthew Garrett wrote:
>>     
>>>>> There's also a policy question here.  On some machines, a lid
>>>>> close will cause the ACPI firmware to program the GPU,
>>>>> disabling the pipe associated with the panel.  Should we detect
>>>>> this and turn it back on at open time?  That could be dangerous
>>>>> if userspace has received the LVDS hotplug event and changed
>>>>> the config out from under us...
>>>>>
>>>>> Comments?
>>>>>           
>>>> It seems that the LID status is used to determine whether the
>>>> LVDS is connected.
>>>> It is not reliable. On some boxes the initial LID status is
>>>> incorrect. Maybe the LID status is open. But the ACPI returns
>>>> that the LID is close. In such case the LVDS is not initialized
>>>> and user can't get the output.
>>>>         
>>> Really? I haven't seen any cases of this. They'll fail in all sorts
>>> of fun ways with modern userland.
>>>
>>>       
>> This is rare, and if this happens, a bug should be filed against ACPI.
>> BTW: we have fixed/root caused all such kind of bugs that have been
>> reported.
>> So I think it makes sense to trust the Lid state reported by ACPI
>> button driver.
>>     
>
> So is that two acks for the patch?  If so, should it be split or can it
> just go in through the i915 driver tree?
>
> Len?  (Patch attached for reference.)
>
> Thanks,
>   
Jesse, Just talked with Rui,  the above status is based on "BIOS upgrade 
or FW fix is acceptable as a bug fix solution". are you ok with this? :) 
Many lid status has to be fixed via action such as DSDT upgrade...


> ------------------------------------------------------------------------
>
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

