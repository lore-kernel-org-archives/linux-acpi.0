From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 3/3] acer-wmi: Update copyright notice & documentation
Date: Sat, 04 Apr 2009 09:12:59 +0100
Message-ID: <20090404081259.9812.30954.stgit@localhost>
References: <20090404081243.9812.3769.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:37592 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1754243AbZDDIUn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 4 Apr 2009 04:20:43 -0400
In-Reply-To: <20090404081243.9812.3769.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Explicitly note in the documentation that the Acer Aspire One is not
supported.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 Documentation/laptops/acer-wmi.txt |   10 +++++++---
 drivers/platform/x86/acer-wmi.c    |    2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)


diff --git a/Documentation/laptops/acer-wmi.txt b/Documentation/laptops/acer-wmi.txt
index 2b3a6b5..5ee2a02 100644
--- a/Documentation/laptops/acer-wmi.txt
+++ b/Documentation/laptops/acer-wmi.txt
@@ -1,9 +1,9 @@
 Acer Laptop WMI Extras Driver
 http://code.google.com/p/aceracpi
-Version 0.2
-18th August 2008
+Version 0.3
+4th April 2009
 
-Copyright 2007-2008 Carlos Corbacho <carlos@strangeworlds.co.uk>
+Copyright 2007-2009 Carlos Corbacho <carlos@strangeworlds.co.uk>
 
 acer-wmi is a driver to allow you to control various parts of your Acer laptop
 hardware under Linux which are exposed via ACPI-WMI.
@@ -36,6 +36,10 @@ not possible in kernel space from a 64 bit OS.
 Supported Hardware
 ******************
 
+NOTE: The Acer Aspire One is not supported hardware. It cannot work with
+acer-wmi until Acer fix their ACPI-WMI implementation on them, so has been
+blacklisted until that happens.
+
 Please see the website for the current list of known working hardare:
 
 http://code.google.com/p/aceracpi/wiki/SupportedHardware
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index bfba6f7..ab03fec 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1,7 +1,7 @@
 /*
  *  Acer WMI Laptop Extras
  *
- *  Copyright (C) 2007-2008	Carlos Corbacho <carlos@strangeworlds.co.uk>
+ *  Copyright (C) 2007-2009	Carlos Corbacho <carlos@strangeworlds.co.uk>
  *
  *  Based on acer_acpi:
  *    Copyright (C) 2005-2007	E.M. Smith

