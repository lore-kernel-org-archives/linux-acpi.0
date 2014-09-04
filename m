From: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Subject: ACPI: Invalid active2 threshold
Date: Thu, 4 Sep 2014 18:40:04 +0200
Message-ID: <201409041840.04182.a.miskiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:42548 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbaIDQkH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 12:40:07 -0400
Received: by mail-we0-f171.google.com with SMTP id u56so10576064wes.16
        for <linux-acpi@vger.kernel.org>; Thu, 04 Sep 2014 09:40:06 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rjw@rjwysocki.net, rui.zhang@intel.com


Hi.

I'm using 3.17.0-rc3-00002-g7505cea kernel on Dell XPS 15 machine:
DMI: Dell Inc. XPS 15 9530/XPS 15 9530, BIOS A06 07/16/2014
(this is latest bios)

After loading thermal acpi driver I get:

[54136.633643] ACPI: Invalid active2 threshold
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[54136.633761] thermal LNXTHERM:00: registered as thermal_zone6
[54136.633763] ACPI: Thermal Zone [TZ00] (28 C)
[54136.634009] thermal LNXTHERM:01: registered as thermal_zone7
[54136.634011] ACPI: Thermal Zone [TZ01] (-266 C)


I assume bios is buggy (right?)

What problems can happen to this machine due to this problem? It is qui=
te hot=20
frequently, so I wonder if there is some thermal management problem wit=
h it.

Thanks,
--=20
Arkadiusz Mi=C5=9Bkiewicz, arekm / maven.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
