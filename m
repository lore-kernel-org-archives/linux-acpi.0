From: <Mario.Limonciello@dell.com>
Subject: Backporting patches that fix TBT at bootup
Date: Thu, 7 Dec 2017 23:23:25 +0000
Message-ID: <6677505e9b3347468bf639b7b14de11a@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:22085 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752326AbdLGXX1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Dec 2017 18:23:27 -0500
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: mika.westerberg@intel.com

Hi,

During kernel 4.14 some issues were fixed for Thunderbolt enumeration at bo=
otup. =20
They were referenced in an issue
(https://github.com/01org/thunderbolt-software-user-space/issues/24#issueco=
mment-328011428)
There are 3 patches that Mika mentioned would be evaluated to be backported=
 back to 4.13.

As 4.14 has come and gone now, I wanted to see if there was any other thoug=
hts about=20
bringing those back to stable now on 4.13 (or did they come back and I just=
 didn't know?)

ecc1165b8b74 ACPICA: Dispatch active GPEs at init time
1312b7e0caca ACPICA: Make it possible to enable runtime GPEs earlier
eb7f43c4adb4 ACPI / scan: Enable GPEs before scanning the namespace

Thanks!
