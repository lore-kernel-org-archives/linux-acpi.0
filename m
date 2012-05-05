From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3] ACPI: D3 states cleanup
Date: Sat, 05 May 2012 01:24:34 -0400
Message-ID: <4FA4B992.2010808@kernel.org>
References: <1335143029.4927.45.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:63052 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab2EEFYh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 May 2012 01:24:37 -0400
In-Reply-To: <1335143029.4927.45.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, aaron.lu@amd.com

Applied using updated check-in comment below.

thanks,
-Len Brown, Intel Open Source Technology Center

From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] ACPI: Fix D3hot v D3cold confusion

Before this patch, ACPI_STATE_D3 incorrectly referenced D3hot
in some places, but D3cold in other places.

After this patch, ACPI_STATE_D3 always means ACPI_STATE_D3_COLD;
and all references to D3hot use ACPI_STATE_D3_HOT.

ACPI's _PR3 method is used to enter both D3hot and D3cold states.
What distinguishes D3hot from D3cold is the presence _PR3
(Power Resources for D3hot)  If these resources are all ON,
then the state is D3hot.  If _PR3 is not present,
or all _PR0 resources for the devices are OFF,
then the state is D3cold.

This patch applies after Linux-3.4-rc1.
A future syntax cleanup may remove ACPI_STATE_D3
to emphasize that it always means ACPI_STATE_D3_COLD.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Reviewed-by: Aaron Lu <aaron.lu@amd.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c   |  2 +-
 drivers/acpi/scan.c    | 17 +++++++----------
 drivers/pci/pci-acpi.c |  4 ++--
 include/acpi/actypes.h |  7 ++++---
 4 files changed, 14 insertions(+), 16 deletions(-)

