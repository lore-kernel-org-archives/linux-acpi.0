From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 1/5] Documentation - Create laptops sub-directory
Date: Sat, 09 Feb 2008 01:32:03 +0000
Message-ID: <20080209013203.4895.53494.stgit@pacifica>
References: <20080209013157.4895.70128.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:57969 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756068AbYBIBco (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Feb 2008 20:32:44 -0500
In-Reply-To: <20080209013157.4895.70128.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Randy Dunlap <randy.dunlap@oracle.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>

There are currently various laptop drivers floating about with no central
place for their documentation, which is currently scattered around the top
level Documentation/ directory.

So, as a first step, lets create a Documentation sub-directory, and update
the relevant index files. The work of then moving the existing laptop
driver related documentation will then be handled later.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Randy Dunlap <randy.dunlap@oracle.com>
CC: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
CC: Mattia Dongili <malattia@linux.it>
CC: Len Brown <lenb@kernel.org>
---

 Documentation/00-INDEX         |    2 ++
 Documentation/laptops/00-INDEX |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/laptops/00-INDEX


diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 6e9c405..3de34e5 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -227,6 +227,8 @@ kref.txt
 	- docs on adding reference counters (krefs) to kernel objects.
 laptop-mode.txt
 	- how to conserve battery power using laptop-mode.
+laptops/
+	- directory with laptop related info and laptop driver documentation.
 ldm.txt
 	- a brief description of LDM (Windows Dynamic Disks).
 leds-class.txt
diff --git a/Documentation/laptops/00-INDEX b/Documentation/laptops/00-INDEX
new file mode 100644
index 0000000..2edb596
--- /dev/null
+++ b/Documentation/laptops/00-INDEX
@@ -0,0 +1,2 @@
+00-INDEX
+	- This file

