From: Marek Szuba <scriptkiddie@wp.pl>
Subject: Critical temperature trips on a cool Dell Latitude D810
Date: Fri, 6 Jun 2008 16:10:25 +0200
Message-ID: <20080606161025.711c4081@student.if.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from student.if.pw.edu.pl ([194.29.174.5]:54368 "EHLO
	student.if.pw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824AbYFFOQF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Jun 2008 10:16:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello everyone,

I have just read in kernel change log that errors like the one I've
been encountering are to be reported here, so here goes: my Dell
Latitude D810 laptop (with a Pentium III M processor) occasionally trips
on its ACPI critical thermal trip point despite never actually reaching
that temperature.

There is a single thermal trip point defined on this laptop, a critical
S5 set to 101 Celsius. Once in a while the system hits that trip point
and shuts down, despite the fact that temperature monitors (both ACPI
and the I8K one) have never, ever shown it go above 70 Celsius.
Frequency of such trips appears to be correlated to the laptop's
temperature, with trips happening more often when the system runs
hotter - then again, I have even seen it trip while only around 40
Celsius! CONFIG_HWMON is not set in kernel configuration so it doesn't
seem to be a conflict between sensors and ACPI. Last but not least, in
the pre-2.6.23 days, when it was still possible to change the trip point
thresholds by writing to /proc/acpi/thermal_zone/*/trip_points, I
raised that one from 101 to 105 degrees and it seemed to help;
unfortunately this feature no longer seems to be available in more
modern kernels.

For your information, I have seen this problem in each stable kernel
version I've used - from 2.6.20 to the latest 2.6.24 inclusive. ACPI
is compiled into the main kernel. Should you need any more information,
please let me know.

PS. Is there any way of raising the trip point threshold in 2.6.23 and
up? There is thermal.nocrt of course but I wouldn't want to entirely
disable the trip - especially given it's the only one this laptop has.

Yours sincerely,
-- 
MS
