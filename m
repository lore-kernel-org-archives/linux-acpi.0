From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2.6.26-rc] ACPI Thermal Zone driver breaks lm-sensors 2
 userspace
Date: Wed, 25 Jun 2008 19:16:15 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806251913090.3279@localhost.localdomain>
References: <fa.4PGqX9CuLbgiTimfCcon+PlAMxk@ifi.uio.no>
 <fa.PWu620xEt5OlYdOezvRtQriuNjM@ifi.uio.no> <48605935.5070407@shaw.ca>
 <alpine.LFD.1.10.0806232004480.2926@woody.linux-foundation.org>
 <1214279258.3001.76.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:58758 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756675AbYFYXQj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jun 2008 19:16:39 -0400
In-reply-to: <1214279258.3001.76.camel@rzhang-dt.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Robert Hancock <hancockr@shaw.ca>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Rene Herman <rene.herman@keyaccess.nl>, Hans de Goede <j.w.r.degoede@hhs.nl>, Jean Delvare <khali@linux-fr.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Linux Kernel <linux-kernel@vger.kernel.org>



> +config THERMAL_HWMON
> +	bool "Hardware monitoring support"
> +	depends on HWMON=y || HWMON=THERMAL


for
CONFIG_HWMON=m
CONFIG_THERMAL=y
CONFIG_THERMAL_HWMON=n, always.

This is not a change to the logic of the existing ifdefs,
but was wondering if this was your intent, Rui.

-Len

> -#if defined(CONFIG_HWMON) ||	\
> -	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
> +#if defined(CONFIG_THERMAL_HWMON)
> +
>  /* hwmon sys I/F */

