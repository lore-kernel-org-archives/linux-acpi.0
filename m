From: "Bonilla, Alejandro" <abonilla@linuxwireless.org>
Subject: Compaq V2000 Fan Control
Date: Fri, 24 Mar 2006 14:28:15 -0600
Message-ID: <1143232095.4053.5.camel@ubuntu.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:22750
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1751139AbWCXU2W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2006 15:28:22 -0500
Received: from [192.168.1.14] ([200.91.94.134])
	by linuxwireless.org.ve.carpathiahost.net (8.12.10/8.12.10) with ESMTP id k2OKSKOQ031296
	for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2006 15:28:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I'm trying to make my Compaq laptop give me control over the fan using
ACPI, but this ain't working. I have to be honest. I don't know much
about debugging acpi or about tools that will tell me much more.

Here is what I try:

echo 100:0:50:80:70:50 > /proc/acpi/thermal_zone/THR1/trip_points

If I set the critical to a value lower than what it is now, it will halt
the PC, which is good. (100)

If I set the passive to 50, nothing occurs. The Fan is not kicked if the
temp is higher, like 60c.

I was told the last value is the one that triggers the Fan. Still, it
just won't work for me.

This is the value that comes up on boot:
cat /proc/acpi/thermal_zone/THR1/trip_points 
critical (S5):           95 C
passive:                 88 C: tc1=2 tc2=3 tsp=50 devices=0xdf64a940

If I set the critical value to something really low, the Fan will kick
in at it's full power and will try to cool down the PC, but that is
while it's already halting.

Anyone has a clue for me?

Thanks,
.Alejandro


