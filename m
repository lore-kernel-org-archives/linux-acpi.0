From: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: ACPI/APD Making Module
Date: Mon, 12 Sep 2016 04:09:36 +0000
Message-ID: <MWHPR12MB1774E8455E7702E1EDD73CD0A0FF0@MWHPR12MB1774.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-by2nam01on0045.outbound.protection.outlook.com ([104.47.34.45]:41136
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756628AbcILFmZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Sep 2016 01:42:25 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,
Current implementation of acpi_apd.c makes AMD I2C,GPIO and UART from acpi =
devices to platform devices. This is done as part of boot sequence.  For so=
me reason i would like to make it kernel module. The current implementation=
 calls acpi_apd_create_device as part of attach callback. Now this entire p=
rocess is part of acpi bus scan functionality. Can someone please help me i=
f i can make this file into kernel module and still get the same functional=
ity.

Thanks=20
Nehal














=09

=09
