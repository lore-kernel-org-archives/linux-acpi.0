From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Commit ac3ebafa81a makes NHM EX/EP machines hung out since
 3.9-rc1
Date: Tue, 26 Mar 2013 01:44:20 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C9482976AE4D@FMSMSX108.amr.corp.intel.com>
References: <20130313022759.GA120840@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24540 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753628Ab3CZBoW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Mar 2013 21:44:22 -0400
In-Reply-To: <20130313022759.GA120840@bee>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Xie, ChanglongX" <changlongx.xie@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lkp@linux.intel.com" <lkp@linux.intel.com>



> -----Original Message-----
> From: Xie, ChanglongX
> Sent: Tuesday, March 12, 2013 10:28 PM
> To: Brown, Len
> Cc: Daniel Lezcano; linux-acpi@vger.kernel.org; lkp@linux.intel.com
> Subject: Commit ac3ebafa81a makes NHM EX/EP machines hung out since 3.9-
> rc1
> 
> Hi Len,
> 
> 	FYI, since 3.9-rc1 our three NHM EP/EX LKP(linux kernel
> performance) test servers
> 	except SNB/IVB/WSM hung up unexpectly.
> 
> 	We did git bisect for about 8 times on all servers, it said that
> the first bad commit is ac3ebafa.
> 
> 	commit ac3ebafa81af76d65e4fb45c6388f08e90ddcc6d
> 	Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> 	Date:   Mon Feb 4 22:44:43 2013 +0000
> 
> 	ACPI / idle: remove usage of the statedata
> 
> 	Len Brown sent a patch to remove this field in the intel_idle
> driver.
> 	The other user of this field is the davinci cpuidle driver and a
> 	patch has been sent to remove the usage of it.
> 	This patch removes the last user of this field.
> 
> 	Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 	Signed-off-by: Len Brown <len.brown@intel.com>
> 
> 
> 	More, all machines hung with following similar info. Would you
> please have a look at it?
> 
> 	178748 ^[%Gmodprobe (1602) used greatest stack depth: 5504 bytes
> left^M
> 	2178749 modprobe (1606) used greatest stack depth: 5472 bytes
> left^M
> 
> 	2178751 Task dump for CPU 1:^M
> 	2178752 swapper/1       R  running task     6736     0      1
> 0x00000000^M
> 	2178753  ffff8801e8029dc8 ffffffff8101cf96 ffff8801e8029e28
> ffffffff813d294b^M
> 	2178754  0000000000000f99 0000000000000003 00000000003cf654
> 0000000025c17d03^M
> 	2178755  ffff8801e8029e38 ffff8801e74fc000 00000002590dc5c4
> ffffffff8163cdb0^M
> 	2178756 Call Trace:^M
> 	2178757  [<ffffffff8101cf96>] ?
> acpi_processor_ffh_cstate_enter+0x2d/0x2f^M
> 	2178758  [<ffffffff813d294b>] acpi_idle_enter_bm+0x1b1/0x236^M
> 	2178759  [<ffffffff8163cdb0>] ? disable_cpuidle+0x10/0x10^M
> 	2178760  [<ffffffff8163cdc2>] cpuidle_enter+0x12/0x14^M
> 	2178761  [<ffffffff8163d286>] cpuidle_wrap_enter+0x2f/0x6d^M
> 	2178762  [<ffffffff8163d2d4>] cpuidle_enter_tk+0x10/0x12^M
> 	2178763  [<ffffffff8163cdd6>] cpuidle_enter_state+0x12/0x3a^M
> 	2178764  [<ffffffff8163d4a7>] cpuidle_idle_call+0xe8/0x161^M
> 	2178765  [<ffffffff81008d99>] cpu_idle+0x5e/0xa4^M
> 	2178766  [<ffffffff8174c6c1>] start_secondary+0x1a9/0x1ad^M
> 	2178767 Task dump for CPU 2:^M

Hmm, is it possible that the nth CPU is trying to use
an idle state before acpi_cstate[] is initialized?

Does bootin with maxcpus=1 work fine?

how about booting with processor.max_cstate=1?

-Len

> 
> Best regards
> Changlong Xie
> 
> ---
> Linux Kernel Performance (LKP) project        Open Source Technology
> Center
> 			                      Intel CorporationIntel Corporation
