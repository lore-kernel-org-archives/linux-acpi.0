From: Johannes Stezenbach <js@sig21.net>
Subject: Re: Cherryview wake up events
Date: Tue, 20 Sep 2016 17:59:43 +0200
Message-ID: <20160920155943.zrj7wwgg7ugqyv6i@sig21.net>
References: <20160919112117.55dim46nmqdmqjan@sig21.net>
 <20160919115619.GF1811@lahna.fi.intel.com>
 <20160919203622.ujh4l5eudrncv3rl@sig21.net>
 <20160920091840.GN1811@lahna.fi.intel.com>
 <20160920101450.ylohouriienzrgtj@sig21.net>
 <20160920104014.GO1811@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:46817 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbcITP7s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Sep 2016 11:59:48 -0400
Content-Disposition: inline
In-Reply-To: <20160920104014.GO1811@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 20, 2016 at 01:40:14PM +0300, Mika Westerberg wrote:
> Can you check if you have:
> 
>   Hardware Reduced (V5) : 1
> 
> in that FADT table?

Nope, it is "Hardware Reduced (V5) : 0".  Now the FADT is also at
https://linuxtv.org/~js/e200ha/

> If yes, it probably does not have the normal Fixed power button but
> instead it has something called "Windows button array device" with
> _HID/_CID of PNP0C40. Looking at your dsdt.dsl, this looks to be the
> case.
> 
> That device is driven by soc_button_array.c driver which can be enabled
> with CONFIG_KEYBOARD_GPIO=y and CONFIG_INPUT_SOC_BUTTON_ARRAY=y. Can you
> check if you have that enabled already?
> 
> You should actually see it in /proc/interrupts with names like "power"
> and so on.

I added CONFIG_INPUT_SOC_BUTTON_ARRAY=y, but no joy.
Maybe because the _HID is INTCFD9, only _CID is PNP0C40?
It also has a _DSM with UUID dfbcf3c5-e7a5-44e6-9c1f-29c76f6e059c.

BTW, lsinput already lists two "Power Button" devices,
   phys    : "PNP0C0C/button/input0"
   phys    : "LNXPWRBN/button/input0"

None of them generates events in input-events.


Thanks,
Johannes
