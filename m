From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: rc6+ regression - backlight reset to 0 on boot after
	7c0ea45be4f114d85ee35caeead8e1660699c46f
Date: Thu, 03 Apr 2008 09:59:39 +0800
Message-ID: <1207187979.25346.8.camel@yakui_zhao.sh.intel.com>
References: <200804022253.17862.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16487 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757581AbYDCCEI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Apr 2008 22:04:08 -0400
In-Reply-To: <200804022253.17862.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2008-04-02 at 22:53 +0400, Andrey Borzenkov wrote:
> Commit 7c0ea45be4f114d85ee35caeead8e1660699c46f registers ACPI backlight
> even if _BQC method (query current backlight level) is missing. The effect is:
> 
> during initialization video.c:acpi_video_device_find_cap() calls backlight_update_status(). It tries to fetch actual level via acpi_video_get_brightness() - but as _BQC is missing it just returns current value
> as stored in memory - i.e. zero, because it was never set. So effectively
> backlight_update_status() reset brightness to minimal value == 0.
> 
> This happens on Toshiba Portege 4000. Verified by reverting commit on top of
> rc8.
It seems that _BQC object is missing on the Toshiba Portege 4000. And
acpi video driver will continue to update the status of backlight even
when _BQC object is missing, which is inappropriate. 
Maybe it is more appropriate that OS doesn't update the status of
backlight in boot phase when _BQC object is missing.

Of course please attach the output of acpidump in kernel bugzilla.
http://bugzilla.kernel.org/show_bug.cgi?id=10387
> On a side note, it would be nice to fit backlight device into actual ACPI
> device tree instead of /devices/virtual.

