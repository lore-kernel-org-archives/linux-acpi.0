From: "Marco Calviani" <marco.calviani@gmail.com>
Subject: Acer Aspie 5720 thermal issues
Date: Thu, 11 Oct 2007 18:12:19 +0200
Message-ID: <da5cd1900710110912h674e3451he3d80e4137e3e1cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:64382 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760AbXJKQMV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Oct 2007 12:12:21 -0400
Received: by nz-out-0506.google.com with SMTP id s18so472997nze
        for <linux-acpi@vger.kernel.org>; Thu, 11 Oct 2007 09:12:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi list,
    i have thermal problems with my Acer Aspire 5720 (Santa Rosa,
T7300 Intel Core 2 Duo).
In particular:

# cat /proc/acpi/thermal_zone/TZ01/trip_points
critical (S5):           100 C

so that there is no rules for activating the fans (and cat
/proc/acpi/fan/ in empty, but as suggested by the acpi_acer driver,
this is normal for Acer laptops). The only way to control the laptop
CPU temperature is with the coretemp module (but it does not swith on
the fans when the temperature increases anyway).

Additionally
proc/acpi/thermal_zone/TZ01/temperature does not get updated neither
if i change the polling_freqency, so that even if the core temperature
reaches 70-80C the fans never starts.

I've also tried to install acer_acpi in order to
see f this can change the situation, but in fact the module fail when
it comes to load :

acer_acpi: Acer Laptop ACPI Extras version 0.9.1
acer_acpi: No or unsupported WMI interface, unable to load.

My original DSDT table is here (thanks to Carlos):
http://aceracpi.googlecode.com/svn/trunk/dsdt/acer/aspire/5720.dsl
It does not compile again (so is a buggy dsdt): i've manage to wipe
out the errors but still warning remais. However when it comes to
include it into the kernel, during startup the system hang up at CPU
recognition.

I'm using Gentoo Linux with kernel version 2.6.22. i've tried also
with 2.6.23-rc8-mm2, but it is the same.

Thanks in advance,
Marco
