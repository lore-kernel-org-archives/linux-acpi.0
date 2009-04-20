From: =?ISO-8859-1?Q?Anders_H=E4ggstr=F6m?= <hagge.lists@intercorner.net>
Subject: DMI info from Dell-server PE860 running Debian Lenny (5.0.0)
Date: Mon, 20 Apr 2009 17:10:30 +0200
Message-ID: <1a5a68400904200810s40adcb87p7f70aeb7661319f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:39963 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbZDTPKc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Apr 2009 11:10:32 -0400
Received: by bwz7 with SMTP id 7so1255643bwz.37
        for <linux-acpi@vger.kernel.org>; Mon, 20 Apr 2009 08:10:30 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I found the following in dmesg during a system installation. I have
not tried "acpi_osi=3DLinux" and will not do until you can give me a
good explanation why I should, or point me to some good documentation
about what changes are made and what result I should expect.

[    0.423679] ACPI: EC: Look up EC in DSDT
[    0.427244] ACPI: BIOS _OSI(Linux) query ignored
[    0.427246] ACPI: DMI System Vendor: Dell Computer Corporation
[    0.427247] ACPI: DMI Product Name: PowerEdge 860
[    0.427248] ACPI: DMI Product Version:
[    0.427249] ACPI: DMI Board Name: 0KM697
[    0.427251] ACPI: DMI BIOS Vendor: Dell Computer Corporation
[    0.427252] ACPI: DMI BIOS Date: 10/04/2007
[    0.427253] ACPI: Please send DMI info above to linux-acpi@vger.kern=
el.org
[    0.427255] ACPI: If "acpi_osi=3DLinux" works better, please notify
linux-acpi@vger.kernel.org


Regards
Anders H=E4ggstr=F6m
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
