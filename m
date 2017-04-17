From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPICA: Export mutex functions
Date: Tue, 18 Apr 2017 00:56:24 +0200
Message-ID: <CAJZ5v0hvYx5zreXbiU+Af3MbhgPsRQy+hw1EjJ9UiVRSOJn8Tg@mail.gmail.com>
References: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5924DB@ORSMSX110.amr.corp.intel.com>
 <20170412212241.GA12384@roeck-us.net> <1AE640813FDE7649BE1B193DEA596E886CE92A85@SHSMSX101.ccr.corp.intel.com>
 <20170417155646.GA8730@roeck-us.net> <94F2FBAB4432B54E8AACC7DFDE6C92E37E59332C@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E59345B@ORSMSX110.amr.corp.intel.com>
 <20170417194527.GA16734@roeck-us.net> <94F2FBAB4432B54E8AACC7DFDE6C92E37E593580@ORSMSX110.amr.corp.intel.com>
 <20170417210353.GA19771@roeck-us.net> <CAJZ5v0jyxRH_B7Yj7HxRdxhofZjgRf175WqmyjtsupWPQYx6tQ@mail.gmail.com>
 <20170417223257.GA22495@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35376 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756671AbdDQW4Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Apr 2017 18:56:25 -0400
In-Reply-To: <20170417223257.GA22495@roeck-us.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>

On Tue, Apr 18, 2017 at 12:32 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Apr 17, 2017 at 11:29:38PM +0200, Rafael J. Wysocki wrote:
>> On Mon, Apr 17, 2017 at 11:03 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> > On Mon, Apr 17, 2017 at 08:40:38PM +0000, Moore, Robert wrote:
>> >>

[cut]

>> >> [Moore, Robert]
>> >>
>> >> I'm not an expert on the _DLM method, but I would point you to the description section in the ACPI spec, 5.7.5 _DLM (DeviceLock Mutex).
>> >>
>> >
>> > I did. However, not being an ACPI expert, that doesn't tell me anything.
>>
>> Basically, if the kernel and AML need to access a device concurrently,
>> there should be a _DLM object under that device in the ACPI tables.
>> In that case it is expected to return a list of (AML) mutexes that can
>> be acquired by the kernel in order to synchronize device access with
>> respect to AML (and for each mutex it may also return a description of
>> the specific resources to be protected by it).
>>
>> Bottom line: without _DLM, the kernel cannot synchronize things with
>> respect to AML properly, because it has no information how to do that
>> then.
>
> That is all quite interesting. I do see the mutex in question used on various
> motherboards from various vendors (I checked boards from Gigabyte, MSI, and
> Intel). Interestingly, the naming seems to be consistent - it is always named
> "MUT0". For the most part, it seems to be available on more recent
> motherboards; older motherboards tend to use the resource without locking.
> However, I don't see any mention of "_DLM" in any of the DSDTs.
>
> At the same time, access to ports 0x2e/0x2f is widely used in the kernel.
> As mentioned before, it is used in watchdog, hardware monitoring, and gpio
> drivers, but also in parallel port and infrared driver code. Effectively
> that means that all this code is inherently unsafe on systems with ACPI
> support.

If AML accesses those ports via operation regions, then it is unsafe.

Note, however, that the mere existence of operation regions covering
them doesn't automatically mean that they are accessed by any AML on
the given platform.

> I had thought about implementing a set of utility functions to make the kernel
> code safer to use if the mutex is found to exist. Right now I wonder, though,
> if such code would have a chance to be accepted. Any thoughts on that ?

You can argue that there should be _DLM objects in the ACPI tables on
those platforms, but they are missing, so platform quirks (or
something else to that effect) are needed to ensure mutual exclusion
between AML accesses and direct accesses in drivers etc.

Unlike in the DT case, we have no influence on what the vendors put
into the ACPI tables on their systems, so we need to live with what is
in there and possibly fix up things as needed.

Thanks,
Rafael
