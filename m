From: xuqiang <likes@huawei.com>
Subject: an error an bug
Date: Wed, 30 Jan 2008 11:14:31 +0800
Message-ID: <0JVF00AOLT076N@szxml04-in.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([61.144.161.53]:47329 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266AbYA3DYi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jan 2008 22:24:38 -0500
Received: from huawei.com (szxga01-in [172.24.2.3])
 by szxga01-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0JVF00HG5T08TH@szxga01-in.huawei.com> for
 linux-acpi@vger.kernel.org; Wed, 30 Jan 2008 11:14:32 +0800 (CST)
Received: from huawei.com ([172.24.1.24])
 by szxga01-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0JVF007Y3T072W@szxga01-in.huawei.com> for
 linux-acpi@vger.kernel.org; Wed, 30 Jan 2008 11:14:32 +0800 (CST)
Received: from x52952 ([10.161.58.135])
 by szxml04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTPA id <0JVF00AOKT076N@szxml04-in.huawei.com> for
 linux-acpi@vger.kernel.org; Wed, 30 Jan 2008 11:14:31 +0800 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "acpi@linux.intel.com" <acpi@linux.intel.com>

hi,all:
   an error happened. in an hour, more than 30 million lines were repea=
ted and writed to /var/log/messages and /var/log/warn.
Jan  1 05:08:06 bond0 kernel:     ACPI-0347: *** Error: Handler for [Sy=
stemMemory] returned AE_NO_MEMORY
Jan  1 05:08:06 bond0 kernel:     ACPI-1133: *** Error: Method executio=
n failed [\_SB_.RDPE] (Node cdf7aec0), AE_NO_MEMORY
Jan  1 05:08:06 bond0 kernel:     ACPI-1133: *** Error: Method executio=
n failed [\_SB_.RPME] (Node cdf7ae20), AE_NO_MEMORY
Jan  1 05:08:06 bond0 kernel:     ACPI-1133: *** Error: Method executio=
n failed [\_GPE._L18] (Node cdf7ad80), AE_NO_MEMORY
Jan  1 05:08:06 bond0 kernel:     ACPI-0295: *** Error: AE_NO_MEMORY wh=
ile evaluating method [_L18] for GPE[ 0]
]
 where can I get enough information to understand the error or who can =
tell me  what the method means?	=09

=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1likes
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1likes@huawei.com
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A12008-01-30


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
