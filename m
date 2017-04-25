From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Tue, 25 Apr 2017 12:24:19 -0400
Message-ID: <3f2c5bcc-3499-d5ef-6955-778979d25b08@codeaurora.org>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0gtLajqCsw0HTS=sL_=cU1aSFzUk6e_kAPAfreuCpak7g@mail.gmail.com>
 <bf1ce91f-b232-4dce-5ed7-597b0ef46f92@codeaurora.org>
 <CAJZ5v0jaGnoCjiU6VuHLyy9Kug8nHzxPxP8tuy3kphtfgmW38w@mail.gmail.com>
 <3f0f2853-d2e5-be32-2bde-47e72c51a0a6@codeaurora.org>
 <20170425070154.GC9999@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980644AbdDYQYW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Apr 2017 12:24:22 -0400
In-Reply-To: <20170425070154.GC9999@wunner.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 4/25/2017 3:01 AM, Lukas Wunner wrote:
> On Sat, Apr 22, 2017 at 12:48 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 4/21/2017 6:43 PM, Rafael J. Wysocki wrote:
>>> +late_initcall(ged_init);
>>> Does this fix the problem?
>>>
>>> What about if the module in question is loaded after running
>>> late_initcalls?
>>
>> This fixed the issue for me where I had dependencies for QUP I2C driver
>> and GHES drivers. Both of them are modules and get probed via normal
>> module execution path.
>>
>> However, I'm open to improvements.  Do you have a better suggestion?
>> I can try to add some _DEP stuff if it is present, but I remember Linux
>> doesn't like _DEP stuff too much.
> 
> Would it be possible to solve this by just returning -EPROBE_DEFER from the
> ->probe hook if the devices you depend on are not bound yet?
> 

I'm not sure. 

> Alternatively, would it be possible to solve it with a struct device_link?

I wasn't aware of device_link concept. This is something that I will keep in
my mind when I'm dealing with producer/consumer problems with known device
driver instances. It looked very useful.

Here is how the overall relationship between drivers.

| GED | <--->  | Platform specific ACPI AML | <----> Vendor GPIO
                                              <----> Vendor I2C
                                              <----> ACPI GHES
					      <----> Some other driver

The problem with Generic Event Device (GED) is that it produces event
notification facility to the platform specific AML code and GED doesn't
have any idea about the consumers of these interrupts or what platform AML
does. 

GED only sees the interrupts that it needs to register and
knows the ASL code it needs to execute when that interrupt happens.

It is possible for AML code not to use any of these drivers or require
some arbitrary driver as well as vendor specific drivers. It is totally
up to the firmware to decide what to do with this event.

My proposal was to require platform AML code to indicate the dependencies
between GED and drivers on the right side of the picture via _DEP as this
cannot be done via normal kernel mechanisms.

This approach might work in general. However, it also has its own caveats.

All of these drivers on the right side are unrelated to each other. Some
operating system can implement a subset of these drivers.

If I include the dependencies, GED will never load for partial driver situations.
This is also a deal breaker. 

Why would you break some other feature if your OS doesn't support RAS as an
example?

Given all these lose bindings and no driver association, where do we go
from here?

I consider GED as a light version of Embedded controller (EC) implementation. 

How is this problem solved for EC as it has the same problem?

> 
> Thanks,
> 
> Lukas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
