From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Battery info bogus on Lenovo 3000 N100
Date: Fri, 22 Feb 2008 12:55:17 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802221232450.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iabervon.org ([66.92.72.58]:34509 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbYBVSCA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Feb 2008 13:02:00 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm having problems with the battery reporting on my laptop. In 
particular, the LEDs suggest that the battery isn't working at all, but 
/proc/acpi/battery/BAT1/state says it's fine. Furthermore, one time when I 
actually removed the battery entirely, /proc/acpi/.../info said (from 
memory, may be slightly off):

present:                 yes
design capacity:         4000 mAh
last full capacity:      4000 mAh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 420 mAh
design capacity low:     156 mAh
capacity granularity 1:  264 mAh
capacity granularity 2:  3780 mAh
model number:            PABAS024
serial number:           3658Q
battery type:            LION
OEM info:                COMPAL

I've also been noticing for a while that the "remaining capacity" updates 
irregularly and isn't generally current, and it reports the design 
capacity when the state is "charged", even if discharging it at all 
indicates that it's actually a lot lower. I've noticed this from 2.6.17 
(the first kernel I had on this computer) to 2.6.22, the latest I've tried 
here.

CONFIG_ACPI_DEBUG doesn't seem to be showing me anything particularly 
informative (When I remove or insert the battery, I get:
[ACPI Debug]  String: [0x12] "=====QUERY_25=====")

There seem to be BIOS updates available, but nothing looks related.

What information can I collect on this problem?

	-Daniel
*This .sig left intentionally blank*
