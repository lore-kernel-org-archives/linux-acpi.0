From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/3] hpet: convert from ACPI to PNP driver
Date: Wed, 17 Mar 2010 11:34:55 -0600
Message-ID: <20100317173329.31124.69795.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:46334 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab0CQRe5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Mar 2010 13:34:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-acpi@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org, "Venkatesh Pallipadi (Venki)" <venkatesh.pallipadi@intel.com>

The hpet driver parses ACPI _CRS data manually, but PNPACPI already does
that, and it does a more complete job, so we can simplify the hpet driver
quite a bit by taking advantage of that.

---

Bjorn Helgaas (3):
      hpet: convert to PNP driver
      hpet: pass physical address, not entire hpet_data, to hpet_is_known()
      MAINTAINERS: remove obsolete HPET ACPI entry


 MAINTAINERS         |    5 --
 drivers/char/hpet.c |  110 ++++++++++++++-------------------------------------
 2 files changed, 30 insertions(+), 85 deletions(-)
