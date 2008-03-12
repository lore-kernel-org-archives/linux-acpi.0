From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 2/3] acer-wmi: Fix DSDT path in documentation
Date: Wed, 12 Mar 2008 20:12:55 +0000
Message-ID: <20080312201255.2071.33288.stgit@pacifica>
References: <20080312201238.2071.31534.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:45900 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752519AbYCLUNL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 16:13:11 -0400
In-Reply-To: <20080312201238.2071.31534.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 Documentation/laptops/acer-wmi.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/Documentation/laptops/acer-wmi.txt b/Documentation/laptops/acer-wmi.txt
index a346c86..23df051 100644
--- a/Documentation/laptops/acer-wmi.txt
+++ b/Documentation/laptops/acer-wmi.txt
@@ -48,7 +48,7 @@ DSDT.
 
 To send me the DSDT, as root/sudo:
 
-cat /sys/firmware/acpi/DSDT > dsdt
+cat /sys/firmware/acpi/tables/DSDT > dsdt
 
 And send me the resulting 'dsdt' file.
 

