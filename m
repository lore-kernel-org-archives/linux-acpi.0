From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Subject: Frequency scaling, Dell Inspiron 6000
Date: Sun, 29 Jul 2007 16:03:31 +0200
Message-ID: <46AC9E33.3020008@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cicero-fbr1.cybercity.dk ([212.242.40.5]:64037 "EHLO
	cicero-fbr1.cybercity.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762836AbXG2OqI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jul 2007 10:46:08 -0400
Received: from cicero1.cybercity.dk (cicero1.cybercity.dk [212.242.40.4])
	by cicero-fbr1.cybercity.dk (Postfix) with ESMTP id 576523E669C
	for <linux-acpi@vger.kernel.org>; Sun, 29 Jul 2007 16:05:35 +0200 (CEST)
Received: from user3.cybercity.dk (user3.cybercity.dk [212.242.41.36])
	by cicero1.cybercity.dk (Postfix) with ESMTP id 6E1E963EE58
	for <linux-acpi@vger.kernel.org>; Sun, 29 Jul 2007 16:03:33 +0200 (CEST)
Received: from [192.168.1.2] (0x55510b65.adsl.cybercity.dk [85.81.11.101])
	by user3.cybercity.dk (Postfix) with ESMTP id 8DC992557D5
	for <linux-acpi@vger.kernel.org>; Sun, 29 Jul 2007 16:03:32 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Around the time of 2.6.17, I noticed that this machine would no longer=20
scale it's frequency as it used to (i.e. it wouldn't at all, it would=20
before). Furthermore, It reported an internal temperature somewhat near=
=20
10 centigrade higher than before, leading to increased fan noise.

I am uncertain of whether it used to scale using the speedstep-centrino=
=20
module or another one, but found a remark on google on a similar proble=
m=20
stating that it appeared "...after speedstep-centrino had it's guts=20
ripped out in 2.6.18..." (cited from memory).

The CPU of the machine is labeled as centrino compliant, but is in fact=
=20
a Celeron-M, and hence does not support _Enhanced_ Speedstep. However, =
I=20
clearly remember having frequency scaling working with Ubuntu kernel=20
2.6.15, but failing with Ubuntu 2.6.17 (possibly with some 2.6.18 code=20
backported).

Venkatesh Pallipadi did some analysis of the BIOS, and posted a message=
=20
to=20
http://www.dellcommunity.com/supportforums/board/message?board.id=3Dins=
p_bios&thread.id=3D38979=20
, however no replies came forth. I am uncertain as to whether I upgrade=
d=20
the kernel or the bios first, but I think it was kernel first.

I am taking this matter up again, as I have given the machine to my gf,=
=20
who complains about the fan noise, which I imagine will be less of a=20
problem, if the cpu is frequency scaled.

I hope for anyone to take an interest and advise as to what info I=20
should provide.

Best regards,

Sune M=F8lgaard

--=20
A motorcycle is a combination of pony, blow dryer, and vibrator -=20
perfect for girls of all ages.
- Colin MacDonald
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
