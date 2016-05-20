From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: linux-next 20160512 - ACPI issue with screen brightness
Date: Fri, 20 May 2016 13:45:30 +0800
Message-ID: <6674547c-cefb-1b93-893a-7c5909a180a7@intel.com>
References: <4736.1463510462@turing-police.cc.vt.edu>
 <CAJZ5v0jrFoQxLY_ZQrP-HP888swZbvSJPM=xNopC5MgQgnSxNg@mail.gmail.com>
 <6459.1463698397@turing-police.cc.vt.edu>
 <7208.1463713500@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50250 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbcETFpd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 May 2016 01:45:33 -0400
In-Reply-To: <7208.1463713500@turing-police.cc.vt.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On 05/20/2016 11:05 AM, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 19 May 2016 18:53:17 -0400, Valdis.Kletnieks@vt.edu said:
> 
>>>> next-20160512 sets the screen brightness to about 40%-ish or so, rather
>>>> than the 100% intensity I want.

Do you mean after boot, the screen brightness is now 40% instead of the
previous 100%? Are you using a GUI? If so, please boot into console mode
to see if this is still the case as GUI sometimes will change backlight
levels so better isolate its impact when testing.

And please list your backlight interfaces:
# ls /sys/class/backlight
I assume it is acpi_video0 that is controlling your backlight levels,
can you please check if it is still working well?
# cd /sys/class/backlight/acpi_video0
# cat max_brightness
XXX
# echo a_value_smaller_or_euqal_to_XXX > brightness

BTW, do you see any error messages in your dmesg?
Probably you can file a new bug at https://bugzilla.kernel.org under the
ACPI/Power-Video category and attach your dmesg/acpidump there, thanks.
