From: Gerfried Maier <moali@sbox.tugraz.at>
Subject: CPU - Power state (Cx) usage count not working
Date: Mon, 23 Jan 2006 09:19:49 +0100
Message-ID: <43D491A5.6010000@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:58766 "EHLO
	mailrelay1.tu-graz.ac.at") by vger.kernel.org with ESMTP
	id S1751419AbWAWITw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jan 2006 03:19:52 -0500
Received: from [129.27.123.23] (emapc23.tu-graz.ac.at [129.27.123.23])
	by mailrelay1.tu-graz.ac.at (8.13.5/8.13.5) with ESMTP id k0N8JoTo024891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2006 09:19:50 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi everybody!

According to the ACPI4Linux doc

cat /proc/acpi/processor/CPU0/power

should look like

active state:            C2
default state:           C1
bus master activity:     00004f00
states:
    C1:                  promotion[C2] demotion[--] latency[000]
usage[00033670]
   *C2:                  promotion[C3] demotion[C1] latency[084]
usage[00357060]
    C3:                  promotion[--] demotion[C2] latency[120]
usage[00000000]

Unfortunaltely on my system (P4m 1800Mhz; 2.4.31 or .32) the usage count
shows always 00000000. Unloading several modules (eg usb-ohci) has no
effect.

IIrc the count and the statistics were working in earlier times (arond
2.4.25+) All of them vanilla with the preemptive patch from
http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/

Is there anything I can do to figure out more on the reason?
Of course I would like to know whether this is only a symptom for a
minor proble or wheher the whole power-state thing is not working,
resulting in shorter battery life.

Thanks for your help!

G. Maier
