From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 0/4] Export APIs to copy device properties & more
Date: Thu, 09 Feb 2017 14:52:05 +0100
Message-ID: <21574795.WBFFfZTmRr@aspire.rjw.lan>
References: <20170203014128.317-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63733 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752067AbdBIN4z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2017 08:56:55 -0500
In-Reply-To: <20170203014128.317-1-dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Thursday, February 02, 2017 05:41:24 PM Dmitry Torokhov wrote:
> Hi,
> 
> Here is the refreshed series exporting APIs to copy statically declared
> device properties. The reason is that we want to augment ACPI-based devices
> with properties, and drivers usually have a largish DMI table for multiple
> models, so it is desirable to mark everything as __initdata/__initconst,
> and then copy only the entry matching the device we are running on and
> discard the rest.
> 
> The last patch is not really about device property APIs, but rather
> allowing users to attach properties to i2c_board_info, and have them
> attached to instantiated device(s). The reason it is included is because it
> depends on device_add_properties() taking const pointer, which is patch #1.
> 
> If it seems useful I hope Rafael and Wolfram would figure a way to merge it
> :) and ideally give me a stable branch as I have more patches to
> platform/chrome and Atmel touchscreen driver depending on them.
> 
> v5:
> - reshuffle order of patches so that "constness" ones are first
> - factor out property_entry_free_data() and make sure we call it for
>   properties already successfully copied when property_entry_copy_data()
>   in property_entries_dup() fails
> - dropped old Acks as patches changed enough

All [1-4/4] applied.

Thanks,
Rafael

