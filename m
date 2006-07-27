From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Generic battery interface
Date: Fri, 28 Jul 2006 01:31:54 +0200
Message-ID: <20060727233154.GB4907@suse.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <20060727221632.GE3797@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:25809 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750707AbWG0XcI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jul 2006 19:32:08 -0400
Content-Disposition: inline
In-Reply-To: <20060727221632.GE3797@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: "Brown, Len" <len.brown@intel.com>, Shem Multinymous <multinymous@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On Fri, Jul 28, 2006 at 12:16:32AM +0200, Pavel Machek wrote:


> /dev/XXX
> + battery layer will need to be invented
> - that layer will need maintainer
> + maintainer ensures this is not a mess, allocates numbers

  and figures out which features are identical, which not, etc. This
  	will actually be a lot easier than with keyboards: The number of
	different battery drivers/types is rather limited fortunately.

  note: It's absolutely necessary to limit the API to a well usable
	SUBSET of a superset of the features of all drivers/devices,
	even sacrificing obscure features to keep the API sane. One
	example would be the HID Power spec, which simply can't be
	supported to full extent by any sane API.

> - does not quite suit zaurus-style batteries, that can _only_ be
> 	polled. Can be worked-around by polling from kernel (and we
> 	are often doing that, anyway)

  + and the kernel can change the polling frequency based on power
	saving state changes

> + userspace backdoor interface will need to be invented, /dev/uinput style
> - hard to handle obscure features
> 	(do_not_charge_battery_for_X_minutes), and we'll probably want
> 	to unify batteries a bit, probably loosing precision.

-- 
Vojtech Pavlik
Director SuSE Labs
