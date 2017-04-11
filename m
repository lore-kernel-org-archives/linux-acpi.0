From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / scan: Set the visited flag for all enumerated devices
Date: Tue, 11 Apr 2017 16:29:50 +0200
Message-ID: <CAJZ5v0ixW6D-HaiBN7U-pHOSVf=0eTMqvfheFBd0oinKhdqruw@mail.gmail.com>
References: <1749017.AgSQtRUy3j@aspire.rjw.lan> <20170411093628.GT2957@lahna.fi.intel.com>
 <CAJZ5v0gbeF=zG_H9ZJasOpojx0mVJDa_4+0JB9sgAYHJs5ASrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35647 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdDKO34 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Apr 2017 10:29:56 -0400
In-Reply-To: <CAJZ5v0gbeF=zG_H9ZJasOpojx0mVJDa_4+0JB9sgAYHJs5ASrg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Apr 11, 2017 at 4:15 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Apr 11, 2017 at 11:36 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
>> On Tue, Apr 11, 2017 at 12:23:42AM +0200, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Commit 10c7e20b2ff3 (ACPI / scan: fix enumeration (visited) flags for
>>> bus rescans) attempted to fix a problem with ACPI-based enumerateion
>>> of I2C/SPI devices, but it forgot to ensure that the visited flag
>>> will be set for all of the other enumerated devices, so fix that.
>>>
>>> Fixes: 10c7e20b2ff3 (ACPI / scan: fix enumeration (visited) flags for bus rescans)
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Thanks for the review, but I'm actually unsure about one thing.
>
> Namely, we may want to call acpi_default_enumeration(device) even if
> an ACPI driver has been bound to the device.
>
> The reason why is because this runs before driver modules are loaded
> (and quite likely before ACPI drivers are registered too) and
> acpi_default_enumeration(device) is going to be invoked even if there
> is a matching ACPI driver, but it is registered later.  That driver
> can still bind to the device object going forward, of course, so there
> can be an ACPI device object with both a companion "physical" device
> and an ACPI driver bound at the same time anyway.
>
> However, if acpi_bus_scan() is called for the same device as a result
> of a bus/device check notification, for example, the
> acpi_default_enumeration(device) will be skipped for device objects
> with ACPI drivers bound (as of the current version of the patch) which
> is quite inconsistent IMO.

Well, the unpatched code does not call
acpi_default_enumeration(device) on device objects with ACPI drivers
bound, so I guess that may be a change on top of the current patch.

I'll go ahead with the patch as is, sorry for the noise.

Thanks,
Rafael
