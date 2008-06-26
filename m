From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2.6.26-rc] ACPI Thermal Zone driver breaks lm-sensors 2
	userspace
Date: Thu, 26 Jun 2008 08:57:56 +0800
Message-ID: <1214441876.3001.175.camel@rzhang-dt.sh.intel.com>
References: <fa.4PGqX9CuLbgiTimfCcon+PlAMxk@ifi.uio.no>
	 <fa.PWu620xEt5OlYdOezvRtQriuNjM@ifi.uio.no> <48605935.5070407@shaw.ca>
	 <alpine.LFD.1.10.0806232004480.2926@woody.linux-foundation.org>
	 <1214279258.3001.76.camel@rzhang-dt.sh.intel.com>
	 <alpine.LFD.1.10.0806251913090.3279@localhost.localdomain>
	 <4862D704.80607@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27291 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbYFZA51 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jun 2008 20:57:27 -0400
In-Reply-To: <4862D704.80607@keyaccess.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Robert Hancock <hancockr@shaw.ca>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Hans de Goede <j.w.r.degoede@hhs.nl>, Jean Delvare <khali@linux-fr.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Linux Kernel <linux-kernel@vger.kernel.org>


On Thu, 2008-06-26 at 07:38 +0800, Rene Herman wrote:
> On 26-06-08 01:16, Len Brown wrote:
> >
> >> +config THERMAL_HWMON
> >> +    bool "Hardware monitoring support"
> >> +    depends on HWMON=y || HWMON=THERMAL
> >
> >
> > for
> > CONFIG_HWMON=m
> > CONFIG_THERMAL=y
> > CONFIG_THERMAL_HWMON=n, always.
> >
> > This is not a change to the logic of the existing ifdefs,
> > but was wondering if this was your intent, Rui.
> 
> My intentioon in this case. Yes, this should be. THERMAL_HWMON is a
> bool
> (as in, not a tristate) that just changes THERMAL.
> 
> If THERMAL=y, we need HWMON=y or we'd get a link failure. If
> THERMAL=m,
> we're okay with either HWMON=y and HWMON=m and if THERMAL=n, we don't
> care one hoot about THERMAL_HWMON...
Agree.

Acked-by: Zhang Rui <rui.zhang@intel.com>



