From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: 2.6.38-rc2: acpi backlight control missing
Date: Fri, 28 Jan 2011 22:12:05 +0100
Message-ID: <1296249125.2006.7.camel@localhost.localdomain>
References: <1295693349.2120.3.camel@localhost.localdomain>
	 <201101222043.07703.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201101222043.07703.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, rui.zhang@intel.com, len.brown@intel.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Am Samstag, den 22.01.2011, 20:43 +0100 schrieb Rafael J. Wysocki:
> On Saturday, January 22, 2011, Thomas Meyer wrote:
> > with 2.6.38-rc2 the acpi backlight is gone:
> > 
> > any ideas?
> 
> Not really, but Matthew may have some (CCed).

Okay, found the problem.

This commit broke my backlight:

commit 677bd810eedce61edf15452491781ff046b92edc
Author: Zhang Rui <rui.zhang@intel.com>
Date:   Mon Dec 6 15:04:21 2010 +0800

    ACPI video: remove output switching control

This is because in function
"acpi_is_video_device()" (drivers/acpi/video_detect.c) the backlight
device is only checked when some video capabilities were found, but by
removing the check for the VIDEO_OUTPUT_SWITCHING (that seems to be the
only video capability on my system) the check for the backlight device
isn't done anymore.

by reverting above commit, the backlight is back again.

kind regards
thomas
