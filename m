From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: 2.6.20-rc6-mm3
Date: Thu, 1 Feb 2007 11:12:18 +0000 (UTC)
Message-ID: <200703011211.09055.fzu@wemgehoertderstaat.de>
References: <20070129204528.eb8d695e.akpm@osdl.org> <20070201080108.GC14378@elte.hu> <200702011144.43774.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout1.freenet.de ([194.97.50.132]:32865 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbXBALLy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Feb 2007 06:11:54 -0500
Date: Thu, 1 Mar 2007 12:11:08 +0100
In-Reply-To: <200702011144.43774.fzu@wemgehoertderstaat.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Am Donnerstag, 1. Februar 2007 11:44 schrieb Karsten Wiese:
> I think the wait is caused by an interrupt starting somewhere under
> sysdev_resume(void).
> possibly lapic timer interrupt? Will try to trace that.

Some evidence:
[root@a64 Desktop]# echo reboot > /sys/power/disk
[root@a64 Desktop]# cat /proc/interrupts; echo disk > /sys/power/state ; cat /proc/interrupts
<snip>
LOC:    2215504
<snip, cmos clock untouched>
LOC:    2216432
<snip>
[root@a64 Desktop]# cat /proc/interrupts; echo disk > /sys/power/state ; cat /proc/interrupts
<snip>
LOC:    2225752
<snip, cmos clock advanced by 1 month under biossettings>
LOC:    2238383
<snip>

      Karsten


