From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Two questions about the MADT in ACPI table
Date: Mon, 13 Feb 2017 21:31:38 +0800
Message-ID: <5f035cfc-3de1-235d-b387-cd7add94a5e1@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:24244 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751982AbdBMNcR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2017 08:32:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, rafael@kernel.org, "Zheng, Lv" <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi, Rafael, Lv

May I ask for your help.

Recently, I am very confused about the generation of the MADT
in ACPI table.

1: Why we put all the Apic Ids which flag==1 in front of the
one which flag==0 in MADT?

Just like that:

-----orginal-----------------MADT-------
Apic Id	Enable Flag	Apic Id	Enable Flag
0x00	1		0x00	1
0x02	1		0x02	1
0x04	0		0x10	1
0x06	0		0x12	1
0x10	1		0x04	0
0x12	1		0x06	0
0x14	0		0x14	0
0x16	0		0x16	0

If the flag is the same, It will not change the order.

-----orginal-----------------MADT---------
Apic Id	Enable Flag	Apic Id	Enable Flag
0x00	0		0x00	0
0x02	0		0x02	0
0x04	0		0x04	0
0x06	0		0x06	0
0x10	0		0x10	0
0x12	0		0x12	0
0x14	0		0x14	0
0x16	0		0x16	0


2: If the order rule can be changed ?
If it can be done, What should I do?

Thanks,
Liyang.


