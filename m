From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: How to get /proc/acpi/alarm to work?
Date: Fri, 20 Jan 2006 09:44:16 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F1016C9816@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:57298 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422723AbWATBoQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2006 20:44:16 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanno Mueller <sockpuppet@hanno.de>
Cc: linux-acpi@vger.kernel.org

Hi,
>
>thanks.
>
>Li, Shaohua schrieb:
>> Can you enable the RTC driver? IIRC, without it, the date you see is
>> wrong, which might make you set wrong alarm.
>
>Yes, it is enabled (now). But no, it didn't help.
>
>
>
>I still have two different alarm settings.
>
>1) The setting stored in the BIOS's ACPI section as "RTC alarm". I can
>choose a time and a specific day of the month.
>
>2) The setting stored in /proc/acpi/alarm - there I can only choose the
>time, not the day.
>
>These two settings appear to be completely independent from each other.
>
>Also, the 2nd setting does not work. I can change it and the computer
>remembers it between reboots, but the BIOS does not wake up the system
>from S5. The 1st setting is able to wake up the system.
>
ACPI alarm can only wakeup system from S3 and wakeup from S4 is
optional. IIRC, it can't wakeup system from S5.

Thanks,
Shaohua
