From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 2/4] ACPI: Export struct kset acpi_subsys
Date: Wed, 28 Nov 2007 02:32:09 +0000
Message-ID: <200711280232.10345.carlos@strangeworlds.co.uk>
References: <200711280230.24318.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:43554 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbXK1Cd3 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 27 Nov 2007 21:33:29 -0500
In-Reply-To: <200711280230.24318.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Nashif, Anas" <anas.nashif@intel.com>

Export acpi_subsys so it can be used by modules that want to hook into
/sys/firmware/acpi

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---
 drivers/acpi/bus.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 84f249d..df70370 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -779,4 +779,6 @@ static int __init acpi_init(void)
 	return result;
 }
 
+EXPORT_SYMBOL(acpi_subsys);
+
 subsys_initcall(acpi_init);
-- 
1.5.3.4

