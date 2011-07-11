From: "Michael N. Moran" <mike@mnmoran.org>
Subject: Help: Thermal Event Anomaly
Date: Mon, 11 Jul 2011 18:36:12 -0400
Message-ID: <4E1B7ADC.2000507@mnmoran.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hoster906.com ([64.14.72.78]:48377 "EHLO hoster906.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758177Ab1GKWmz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jul 2011 18:42:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-ACPI <linux-acpi@vger.kernel.org>

Pardon me if I'm in the wrong place, but I'm having
an "interesting" problem with my laptop that seems
to be related to a thermal event.

I frequently perform rather lengthy (30 min) parallel
compiles on my laptop, and have found that at a certain
point, my fan will stay on and two of my processor's
cores will continue at about 40% after the compile is
stopped and "top" shows that the the system is effectively
idle.

I suspect a kernel thread or interrupt interaction for
causing the load on these two cores, since there doesn't
appear to be any processes consuming the CPU resources.

I'm hoping that the expertise on this list can at least
point me to a place in the kernel that may be the cause.

The thermal event seems to happen when the CPU reaches
about 205' Fahrenheit according to KSensor.

The CPU is an i7 740 on a Dell Precision M6500 running
an up-to-date Fedora 14 Linux 2.6.35.13-92.fc14.x86_64 x86_64.

Thank you for any pointers/suggestions. I'll be happy
to help and/or file a bug if I've come to the right
place. Otherwise, if you can point me in the right
direction I'll move on :)

-- 
Michael N. Moran           (h) 770 516 7918
5009 Old Field Ct.         (c) 678 521 5460
Kennesaw, GA, USA 30144    http://mnmoran.org

"So often times it happens, that we live our lives in chains
  and we never even know we have the key."
"Already Gone" by Jack Tempchin (recorded by The Eagles)

The Beatles were wrong: 1 & 1 & 1 is 1
