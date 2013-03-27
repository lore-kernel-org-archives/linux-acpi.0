From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [LKP] Commit ac3ebafa81a makes NHM EX/EP machines hung out since
 3.9-rc1
Date: Wed, 27 Mar 2013 14:11:07 +0100
Message-ID: <5152EFEB.7030107@linaro.org>
References: <20130313022759.GA120840@bee> <5152781B.6060603@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33657 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323Ab3C0NLL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Mar 2013 09:11:11 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so2256606wib.9
        for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2013 06:11:10 -0700 (PDT)
In-Reply-To: <5152781B.6060603@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Shi <alex.shi@intel.com>
Cc: Len Brown <len.brown@intel.com>, Changlong Xie <changlongx.xie@intel.com>, linux-acpi@vger.kernel.org, lkp@linux.intel.com

On 03/27/2013 05:39 AM, Alex Shi wrote:
> On 03/13/2013 10:27 AM, Changlong Xie wrote:
>> Hi Len,
>>
>> 	FYI, since 3.9-rc1 our three NHM EP/EX LKP(linux kernel performance=
) test servers=20
>> 	except SNB/IVB/WSM hung up unexpectly.=20
>>
>> 	We did git bisect for about 8 times on all servers, it said that th=
e first bad commit is ac3ebafa.=20
>>
>> 	commit ac3ebafa81af76d65e4fb45c6388f08e90ddcc6d
>> 	Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> 	Date:   Mon Feb 4 22:44:43 2013 +0000
>=20
> fixing patch for review:
>=20
>=20
> -----------------------
> From 78a74aea386b0969909c2e4ae388024ce71fdb18 Mon Sep 17 00:00:00 200=
1
> From: Alex Shi <alex.shi@intel.com>
> Date: Tue, 26 Mar 2013 22:57:47 +0800
> Subject: [PATCH] cpuidle/acpi: recover percpu acpi processor cstate
>=20
> Commit: ac3ebafa81af76d6 "ACPI / idle: remove usage of the statedata"
> change the percpu processor cstate to a unify unique cstate in acpi
> idle. That cause all our NHM box boot hang or panic.
>=20
> 2178751 Task dump for CPU 1:^M
> 	2178752 swapper/1       R  running task     6736     0      1
> 0x00000000^M
> 	2178753  ffff8801e8029dc8 ffffffff8101cf96 ffff8801e8029e28
> ffffffff813d294b^M
> 	2178754  0000000000000f99 0000000000000003 00000000003cf654
> 0000000025c17d03^M
> 	2178755  ffff8801e8029e38 ffff8801e74fc000 00000002590dc5c4
> ffffffff8163cdb0^M
> 	2178756 Call Trace:^M
> 	2178757  [<ffffffff8101cf96>] ? acpi_processor_ffh_cstate_enter+0x2d=
/0x2f^M
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
>=20
> In fact, the acpi idle bases on percpu cstate difference assumption, =
the
> infrastructure use many percpu structures to implement self.
> Just unique acpi_processor_cx is far far not enough.
>=20
> This patch just is a quick fix by introducing back the percpu cstates=
=2E
> And keep driver_data away.
>=20
> If someone really want to unify the acpi cstates, please make sure wh=
ole
> software infrastructure changed and get the grant from hardware,
> include many kinds of BIOS setting.

Hi Alex,

could you elaborate a bit the explanation. I don't see where is the
analysis of the bug. Why do we have this stack trace ?

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
