From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: battery: Support for non-spec name for LiIon technology
Date: Sun, 28 Oct 2007 15:33:10 +0300
Message-ID: <20071028123310.13302.69554.stgit@samsung>
References: <3e7b9f4b0710280524u1898296ase70f70c9cd03ced0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:57032 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751121AbXJ1Mdx (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sun, 28 Oct 2007 08:33:53 -0400
In-Reply-To: <3e7b9f4b0710280524u1898296ase70f70c9cd03ced0@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Support Li-Ion as possible name for technology.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6c06879..06b68de 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -125,6 +125,8 @@ static int acpi_battery_technology(struct acpi_battery *battery)
 		return POWER_SUPPLY_TECHNOLOGY_NiMH;
 	if (!strcasecmp("LION", battery->type))
 		return POWER_SUPPLY_TECHNOLOGY_LION;
+	if (!strcasecmp("LI-ION", battery->type))
+		return POWER_SUPPLY_TECHNOLOGY_LION;
 	if (!strcasecmp("LiP", battery->type))
 		return POWER_SUPPLY_TECHNOLOGY_LIPO;
 	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;

