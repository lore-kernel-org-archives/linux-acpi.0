From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/4] ACPI / scan: Clean up the handling of the PRP0001 device ID
Date: Thu, 09 Apr 2015 02:18:45 +0200
Message-ID: <4378053.gHTT51U7FJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55746 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754969AbbDHX54 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Apr 2015 19:57:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

This series of patches reworks the handling of the PRP0001 device ID with
the following goals:

 (a) Make PRP0001 work as a _CID too.
 (b) Prevent PRP0001 from overriding the other ACPI/PNP IDs entirely.
 (c) Change ACPI modalias to cover ACPI/PNP/compatible at the same time.

[1/4] Generalize the of_compatible matching routine
[2/4] Simplify acpi_match_device()
[3/4] Take PRP0001 in _CID lists into account too.
[4/4] Rework modalias creation if the "compatible" property is present.

Comments, remarks, testing welcome!

Kind regards,
Rafael

