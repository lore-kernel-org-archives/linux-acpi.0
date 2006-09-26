From: <eiichiro.oiwa.nm@hitachi.com>
Subject: Re[2]: [patch 10/10] Fix incorrect handling PCI-Express Root Bridge
    _HID
Date: Tue, 26 Sep 2006 16:46:35 +0900
Message-ID: <XNM1$9$0$4$$3$3$7$A$9002682U4518dad8@hitachi.com>
References: <200609252328.k8PNSGca002194@shell0.pdx.osdl.net>
    <XNM1$9$0$4$$3$3$7$A$9002679U4518af61@hitachi.com>
    <200609260315.19186.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5]:13534 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1750745AbWIZHqq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Sep 2006 03:46:46 -0400
Received: from mlsv8.hitachi.co.jp (unknown [133.145.228.16])
	by mail4.hitachi.co.jp (Postfix) with ESMTP id 434FA33CCE
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2006 16:46:45 +0900 (JST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org

>> Hi Andrew,
>> 
>> We need this patch for APCI hotplug because APCI parser gets bus number from acpi_object_extra. I already tested this patch by ACPI hotplug, and confirmed there is no problem on our box has described PCI topology.
>> I don't have git rights.
>> Could you merge this patch into Linus's tree?
>
>Eiichiro,
>Thank you for finding and fixing this bug.
>This patch is checked into the upstream ACPICA source tree.
>While I don't expect to pull that whole tree into 2.6.18,
>I do plan to cherry pick this patch with some others for 2.6.19,
>as well as 2.6.18.stable.
>
>thanks,
>-Len

Len,
Thank you for your information.

Eiichiro
