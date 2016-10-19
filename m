From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/5] ACPI / gpio: Updates to properties
Date: Wed, 19 Oct 2016 23:22:03 +0200
Message-ID: <CAJZ5v0j7EfMEjb7F4BMR7O2_U0oipvcMDMf0N4XEoem4ypqE7Q@mail.gmail.com>
References: <20160923145710.105489-1-mika.westerberg@linux.intel.com> <20161019124112.GK1722@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36283 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753897AbcJSVWF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Oct 2016 17:22:05 -0400
In-Reply-To: <20161019124112.GK1722@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Oct 19, 2016 at 2:41 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Fri, Sep 23, 2016 at 05:57:05PM +0300, Mika Westerberg wrote:
>> Hi,
>>
>> This series brings couple of useful GPIO related properties from Device
>> Tree to ACPI _DSD device properties:
>>
>>   - Names for GPIO lines
>>   - GPIO hogging
>>   - Holes in GPIO property lists
>>
>> We are using these to get Intel Galileo better supported in the mainline
>> kernel (but these may be useful for other boards as well). For example SPI
>> chip select on Galileo is connected to a GPIO line so we need to be able to
>> describe it in ACPI, and at the same time allow native chip selects.
>>
>> GPIO hogging can be used to set initial state of certain GPIOs available on
>> the headers regardless of the BIOS settings (which may be wrong as it knows
>> nothing about which devices have been connected).
>>
>> Mika Westerberg (5):
>>   ACPI / documentation: Use recommended name in GPIO property names
>>   ACPI / gpio: Add support for naming GPIOs
>>   ACPI / gpio: Add hogging support
>>   ACPI / property: Allow holes in reference properties
>>   ACPI / gpio: Allow holes in list of GPIOs for a device
>
> Any comments on the GPIO patches in this series?
>
> At least the last one does not add any new bindings so it should be fine
> to apply.

I have no comments, but I'd suggest resending them as a new series on
top of 4.9-rc1 (which includes the generic patches from this series).

You can add my ACK to them if that helps.

Thanks,
Rafael
