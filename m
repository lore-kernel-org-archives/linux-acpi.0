From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 0/2] cleanups in drivers/acpi/scan.c
Date: Thu, 14 May 2009 08:31:26 -0600
Message-ID: <20090514142941.18569.75813.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:26030 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236AbZENUb3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2009 16:31:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Len,

I'm investigating some cleanups in ACPI/PCI bindings, and figured I'd
send these trivial cleanup patches while I work on the real issues.

Thanks.

/ac

---

Alex Chiang (2):
      ACPI: clean up whitespace in drivers/acpi/scan.c
      ACPI: acpi_device_register() should call device_register()


 drivers/acpi/scan.c |   49 ++++++++++++++++++++++---------------------------
 1 files changed, 22 insertions(+), 27 deletions(-)

