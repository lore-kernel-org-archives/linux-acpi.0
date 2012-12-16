From: Sebastian <ML-kernel.org@mueller.mn>
Subject: Some Questions about C-States
Date: Sun, 16 Dec 2012 18:35:29 +0100
Message-ID: <50CE0661.6070601@mueller.mn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.mueller.mn ([85.93.18.63]:42200 "EHLO mail.mueller.mn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab2LPRmv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Dec 2012 12:42:51 -0500
Received: from [10.20.0.117] (HSI-KBW-149-172-93-50.hsi13.kabel-badenwuerttemberg.de [149.172.93.50])
	by mail.mueller.mn (Postfix) with ESMTPSA id 8DD8123305CA
	for <linux-acpi@vger.kernel.org>; Sun, 16 Dec 2012 18:35:29 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I am a little confused about several things around ACPI and C-States. 
Maybe I misunderstood a few things and due to that I did not hit the 
right keywords in search engines and now I hope you can help me.

First of all. I am running a old ASRock 760GM-GS3 with a AMD Athlon II 
X2 240 C3-Stepping (AM3) as a small homeserver, doing some 
virtualisation and vdr stuff on it. Most of the time the cpu is idle, so 
I started little time ago to reduce the power consumption. Today, it is 
using 42W idling. And I am just courious if I might get it lower.

In the BIOS I've got a setting to enable C1E. Doing so, results in

* [    0.161189] process: System has AMD C1E enabled
* [    0.161202] process: Switch to broadcast mode on CPU1
* [    0.161660] process: Switch to broadcast mode on CPU0

shown in dmesg. Followed by

* [    0.676465] ACPI: processor limited to max C-state 1

some lines below.
When I disable C1E in the BIOS, none of the lines is shown up.
Since C1 is not the same as C1E, it seems there is some limit.

So, I tried to figure out if C1E is used, and which C-States are used 
overall.
I read through many sites, some of them were stating that /proc/acpi is 
the place to take a look, others are telling /sys/power or 
/sys/devices/system/cpu/ is the right place to find information about 
C-States. Again others are telling me acpitool -c will show me C-States. 
For me, it shows only

* # acpitool -c
*   CPU type               : AMD Athlon(tm) II X2 240 Processor
*   Min/Max frequency      : 800/2800 MHz
*   Current frequency      : 800 MHz
*   Frequency governor     : ondemand
*   Freq. scaling driver   : acpi-cpufreq
*   Cache size             : 800.000 KB
*   Bogomips               : 5613.25
*   Bogomips               : 5613.25
*   Function Show_CPU_Info : could not read directory /proc/\
acpi/processor/
*   Make sure your kernel has ACPI processor support enabled.


Tested with kernel version 3.7.0 and 3.2.12 and
* [Deprecated] /proc/acpi/*
switch in kernel config enabled.

The modules are loaded, too. But the only file in /proc/acpi is called 
'wakeup'.

Can someone help me getting back on the track? What can I do to show up 
the used c-states?

Cheers,
Sebastian
