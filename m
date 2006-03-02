From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 00:49:53 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr23.intel.com ([143.183.121.15]:13984 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750774AbWCBFuK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2006 00:50:10 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


>sysfs gets it right.
>
>(23:11:01:davej@nemesis:~)$ ls /sys/devices/system/cpu/
>cpu0/  cpu1/
>(23:11:07:davej@nemesis:~)$ ls /proc/acpi/processor/
>CPU1/  CPU2/  CPU3/

This is because the BIOS has three "Processor" objects in the DSDT.

As I've mentioned before, /proc/acpi/*/* should not exist.
Internal ACPI BIOS names "CPU1, CPU1, CPU3" in this case
are actually arbitray 4-character strings, and should
never be exposed to the user in the file-system.

sysfs with cpu0, cpu1 -- predictable strings for objects --
gets it right, and is the direction we are going.

I'm afraid that even after we get this stuff out of /proc
and into sysfs where it belongs, we'll have to leave /proc/acpi around
for a while b/c unfortunately people are under the impression
that the path names there actually mean something and
they can actually count on them -- which they can't.

-Len
