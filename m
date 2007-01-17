From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: i810, mergedfb and lid switch and acpi video
Date: Wed, 17 Jan 2007 12:20:20 +0800
Message-ID: <1C601A6A3344064EB423D0C1E83B717BE6FD77@pdsmsx411.ccr.corp.intel.com>
References: <414cba4e0701150039j27d5ffcaw78e31e4119779872@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9189 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbXAQEUZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jan 2007 23:20:25 -0500
Content-class: urn:content-classes:message
In-Reply-To: <414cba4e0701150039j27d5ffcaw78e31e4119779872@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: emisca <emisca.ml@gmail.com>
Cc: xorg@lists.freedesktop.org, linux-acpi@vger.kernel.org

>Here are the dsdt decompiled, and the acpidump output.
>Could you see also the section related to brightness control? I can

Yes, I found :

Method (_L02,..)
	    If (LEqual (Local0, 0x03))
                {
                    Notify (\_SB.C002.C080.C13F, 0x87)
                }

                If (LEqual (Local0, 0x02))
                {
                    Notify (\_SB.C002.C080.C13F, 0x86)
                }
And:
	_BCL, _BCM under C13F.

But there is NO _BQC. Instead of _BQC, there do have a _BCQ in DSDT.
Is this a bug of BIOS? Acpi video drvier needs _BQC to get the
current brightness level, and to get the next level to set on receiving
notification of 0x86 (Increase Brightness) , 0x87 (decrease Brightness).

Could you just try to replace _BQC with _BCQ in acpi/video.c?


Thanks,
Luming
