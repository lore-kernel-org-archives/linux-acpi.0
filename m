From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Thu, 11 May 2017 09:43:14 -0400
Message-ID: <0a368676-d01a-5ac8-179d-b6e7507fd500@codeaurora.org>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <20170425070154.GC9999@wunner.de>
 <3f2c5bcc-3499-d5ef-6955-778979d25b08@codeaurora.org>
 <1874042.5bWzSJ73x0@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1874042.5bWzSJ73x0@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lukas Wunner <lukas@wunner.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Abdulhamid, Harb" <harba@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On 5/10/2017 8:46 PM, Rafael J. Wysocki wrote:
>> My proposal was to require platform AML code to indicate the dependencies
>> between GED and drivers on the right side of the picture via _DEP as this
>> cannot be done via normal kernel mechanisms.
> Something like _DEP would be needed.
> 
> However, _DEP as specified is only about operation region dependencies, which
> doesn't seem to be applicable here.
> 
> That said, _DEP is used for general dependecies by firmware already, but it
> would at least be good to send a proposal for a spec update regarding that
> before mandating using _DEP for GED.

OK. I'll reach out to Harb and let's see where the proposal goes. 

> 
>> This approach might work in general. However, it also has its own caveats.
>>
>> All of these drivers on the right side are unrelated to each other. Some
>> operating system can implement a subset of these drivers.
>>
>> If I include the dependencies, GED will never load for partial driver situations.
>> This is also a deal breaker. 
> _DEP doesn't mean a hard dependency AFAICS.  It is about ordering, not about
> presence, at least as specified currently.
> 
>> Why would you break some other feature if your OS doesn't support RAS as an
>> example?
>>
>> Given all these lose bindings and no driver association, where do we go
>> from here?
>>
>> I consider GED as a light version of Embedded controller (EC) implementation. 
> No, it is not.

Thanks for correction. Let me repeat with the correct terminology this time. 

Don't we have the same problem on GPE/SCI mechanism?

An event that SCI is delivering may not be handled because the handler of the
event is not present during OS boot?

The SCI relationship would be:

| SCI | <--->  | Platform specific ACPI AML (_AEI) | <----> Vendor XYZ driver
                                              	     <----> Vendor I2C
                                                     <----> ACPI GHES

> 
> It is more of a generalization of the GPE/SCI mechanism in order to make it
> possible to cover things different from GPIO (which already is covered by
> _AEI).
> 
>> How is this problem solved for EC as it has the same problem?
> It doesn't.  The EC relies on the GPE/SCI mechanism to be there and that is
> always present.
> 
> Thanks,
> Rafael


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
