From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: 2.6.20-rc6-mm3
Date: Thu, 1 Feb 2007 11:12:45 +0000 (UTC)
Message-ID: <200703011211.09055.fzu__20644.0988266424$1170328365$gmane$org@wemgehoertderstaat.de>
References: <20070129204528.eb8d695e.akpm@osdl.org> <20070201080108.GC14378@elte.hu> <200702011144.43774.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751724AbXBALLz@vger.kernel.org>
Date: Thu, 1 Mar 2007 12:11:08 +0100
In-Reply-To: <200702011144.43774.fzu@wemgehoertderstaat.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

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
