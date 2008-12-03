From: "Koornstra, Reinoud" <koornstra@hp.com>
Subject: 2.6.28-rc7 acpi error messages
Date: Wed, 3 Dec 2008 21:22:15 +0000
Message-ID: <E92FAF79A8BBC642A36EEE3AA7F152D82A17260164@GVW1089EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:5140 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbYLCVXy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Dec 2008 16:23:54 -0500
Received: from G6W0641.americas.hpqcorp.net (g6w0641.atlanta.hp.com [16.230.34.77])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by g4t0014.houston.hp.com (Postfix) with ESMTPS id B4B32245F7
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2008 21:23:50 +0000 (UTC)
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

HI Everyone,

2.6.28-rc7 works nicely here, I'm only seeing some non critical errors:

[    0.000000] ACPI Error (tbfadt-0471): 32/64X address mismatch in "Gpe0Block": [0000F820] [000000000001F028], using 64X [20080926]
[    0.000000] 2171MB HIGHMEM available.
[    0.000000] 883MB LOWMEM available.
[    0.000999] Memory: 3094036k/3129092k available (3049k kernel code, 33768k reserved, 2026k data, 328k init, 2223884k highmem)

[    0.304598] ACPI Error (dsfield-0139): [CAPD] Namespace lookup failure, AE_ALREADY_EXISTS
[    0.304601] ACPI Error (psparse-0524): Method parse/execution failed [\_SB_.PCI0._OSC] (Node f6c16cf0), AE_ALREADY_EXISTS
[    0.304605] ACPI: Marking method _OSC as Serialized because of AE_ALREADY_EXISTS error
[    0.305297] ACPI Error (dsfield-0139): [CAPD] Namespace lookup failure, AE_ALREADY_EXISTS
[    0.305300] ACPI Error (psparse-0524): Method parse/execution failed [\_SB_.PCI0._OSC] (Node f6c16cf0), AE_ALREADY_EXISTS

Any suggestions?
Kind Regards,

Reinoud.

