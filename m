From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Sun, 21 May 2017 11:51:44 -0400
Message-ID: <0e183b3b-2ab4-e083-d471-ae3afa1abf49@codeaurora.org>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <1874042.5bWzSJ73x0@aspire.rjw.lan>
 <0a368676-d01a-5ac8-179d-b6e7507fd500@codeaurora.org>
 <7848366.O4PImzsRl1@aspire.rjw.lan>
 <b864973e-d52b-12f7-32b2-78ec0b132a0b@codeaurora.org>
 <CAJZ5v0i6p6iZgJGLVgGVanAD3uGjbarp5QihuAd=_eZ8zFQwDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55860 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbdEUPvs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 May 2017 11:51:48 -0400
In-Reply-To: <CAJZ5v0i6p6iZgJGLVgGVanAD3uGjbarp5QihuAd=_eZ8zFQwDw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Abdulhamid, Harb" <harba@codeaurora.org>


Hi Rafael,

On 5/15/2017 6:59 AM, Rafael J. Wysocki wrote:
> On Mon, May 15, 2017 at 4:36 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> Hi Rafael,
>>
>> On 5/11/2017 10:52 AM, Rafael J. Wysocki wrote:
>>>> OK. I'll reach out to Harb and let's see where the proposal goes.
>>> It looks like this is about operation regions after all, however, so _DEP as is
>>> should be sufficient here.
>>>
>>> There is some limited _DEP support in the ACPI layer, but we were missing
>>> a way to represent those dependencies in the driver core.
>>>
>>> That can be done through device_link objects now, so we may be able to support
>>> _DEP in a more meaningful way, but the cases when _DEP is used for something
>>> different from operation regions in practice need to be treated with caution.
>>>
>>>
>>
>> _DEP could certainly help here. However, _DEP doesn't answer the loose binding question.
>> If one driver is missing in one operating system, _GED driver will never load due
>> to unsatisfied dependency. This forces us into all or none condition. We have operating
>> systems that we need to support and do not have vendor I2C or GPIO drivers. That's why,
>> we are hesitant to place _DEP into ACPI tables.
> 
> _DEP as defined in the spec should be fine still.
> 
> Quoting directly:
> 
> "_DEP evaluates to a package and designates device objects that OSPM
> should assign a higher
> priority in start ordering due to future operation region accesses.
> 
> To increase the likelihood that an SPB operation region handler is
> available when needed, OSPM
> needs to know in advance which methods will access it -- _DEP provides
> OSPM with this
> information. While the _DEP keyword may be used to determine start
> ordering, only the _REG
> method (Section 6.5.4) callbacks can be relied upon to determine
> whether a region is accessible at a
> given point in time."
> 
> So according to the above, _DEP is advisory only and you need _REG.
> 
> In theory, because I'm not sure if _REG actually works.

I have been testing _REG this week. It seems to be working just fine. 
We are transitioning our FW to use _REG. 

Our experience with _DEP in other operating systems is a hard dependency
rather than a soft dependency. We have observed some drivers not loading
if the driver providing the dependency is not present at all. That's why,
I have been taking my time evaluating this. 

> 
>> The problem is that there is no concept of per event dependency. This could have helped
>> us figure out if such an interrupt should be enabled or not.
>>
>> Another solution for operating regions is _REG if FW wants to ignore the event during
>> boot. This is the one we are looking into at this moment for non-critical events.
>>
>> late_init proposed in this patch helps for built-in drivers such as GHES where we do
>> not want to ignore events. Since GHES is not an actual device, this has to be solved
>> in ACPI.
> 
> For built-in things it would be better to have explicit initialization
> ordering, eg. initializing both GHES and GED from one initcall in the
> right order.
> 
> Using different initcall levels for them is sort of OK, but then it is
> not quite clear from the code what the specific ordering requirement
> is, so please add a comment describing that at least.

We are doing two things in this front. The first thing is to change GHES so that
the events that happen before boot are handled properly. Tyler Baicar has a patch
for this. This is the right fix.

The second one is this patch. This one is more of a general solution. We can live
without this patch if Tyler's patch is included at this moment. 

This one is to prevent future problems. I can certainly move the init function around.
Maybe, have one acpi_driver_init that calls ghes_init() followed by ged_init().

Please let me know your preference.

> 
> Thanks,
> Rafael
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
