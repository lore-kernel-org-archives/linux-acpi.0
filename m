From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Mon, 15 May 2017 12:59:07 +0200
Message-ID: <CAJZ5v0i6p6iZgJGLVgGVanAD3uGjbarp5QihuAd=_eZ8zFQwDw@mail.gmail.com>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <1874042.5bWzSJ73x0@aspire.rjw.lan> <0a368676-d01a-5ac8-179d-b6e7507fd500@codeaurora.org>
 <7848366.O4PImzsRl1@aspire.rjw.lan> <b864973e-d52b-12f7-32b2-78ec0b132a0b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36237 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdEOK7J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2017 06:59:09 -0400
In-Reply-To: <b864973e-d52b-12f7-32b2-78ec0b132a0b@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Abdulhamid, Harb" <harba@codeaurora.org>

On Mon, May 15, 2017 at 4:36 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Hi Rafael,
>
> On 5/11/2017 10:52 AM, Rafael J. Wysocki wrote:
>>> OK. I'll reach out to Harb and let's see where the proposal goes.
>> It looks like this is about operation regions after all, however, so _DEP as is
>> should be sufficient here.
>>
>> There is some limited _DEP support in the ACPI layer, but we were missing
>> a way to represent those dependencies in the driver core.
>>
>> That can be done through device_link objects now, so we may be able to support
>> _DEP in a more meaningful way, but the cases when _DEP is used for something
>> different from operation regions in practice need to be treated with caution.
>>
>>
>
> _DEP could certainly help here. However, _DEP doesn't answer the loose binding question.
> If one driver is missing in one operating system, _GED driver will never load due
> to unsatisfied dependency. This forces us into all or none condition. We have operating
> systems that we need to support and do not have vendor I2C or GPIO drivers. That's why,
> we are hesitant to place _DEP into ACPI tables.

_DEP as defined in the spec should be fine still.

Quoting directly:

"_DEP evaluates to a package and designates device objects that OSPM
should assign a higher
priority in start ordering due to future operation region accesses.

To increase the likelihood that an SPB operation region handler is
available when needed, OSPM
needs to know in advance which methods will access it -- _DEP provides
OSPM with this
information. While the _DEP keyword may be used to determine start
ordering, only the _REG
method (Section 6.5.4) callbacks can be relied upon to determine
whether a region is accessible at a
given point in time."

So according to the above, _DEP is advisory only and you need _REG.

In theory, because I'm not sure if _REG actually works.

> The problem is that there is no concept of per event dependency. This could have helped
> us figure out if such an interrupt should be enabled or not.
>
> Another solution for operating regions is _REG if FW wants to ignore the event during
> boot. This is the one we are looking into at this moment for non-critical events.
>
> late_init proposed in this patch helps for built-in drivers such as GHES where we do
> not want to ignore events. Since GHES is not an actual device, this has to be solved
> in ACPI.

For built-in things it would be better to have explicit initialization
ordering, eg. initializing both GHES and GED from one initcall in the
right order.

Using different initcall levels for them is sort of OK, but then it is
not quite clear from the code what the specific ordering requirement
is, so please add a comment describing that at least.

Thanks,
Rafael
