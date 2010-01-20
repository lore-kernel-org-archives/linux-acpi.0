From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 0/2] ACPI: Early _PDC tweaks
Date: Wed, 20 Jan 2010 00:06:25 -0700
Message-ID: <20100120070403.19777.31978.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:23002 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab0ATHG0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2010 02:06:26 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

As requested by Len, a few more improvements in how we handle the
early _PDC path.

Allow platforms not listed in the DMI table to opt-in for early _PDC
with a kernel command line param.

If we do evaluate _PDC early, remember that fact and do not evaluate
it a second time when the ACPI processor driver loads.

/ac

---

Alex Chiang (2):
      ACPI: processor: add kernel command line support for early _PDC eval
      ACPI: processor: only evaluate _PDC once per processor


 Documentation/kernel-parameters.txt |    4 ++++
 drivers/acpi/processor_pdc.c        |   14 ++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

