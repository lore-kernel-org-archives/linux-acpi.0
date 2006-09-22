From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [Patch 3/3] ibm-acpi: Add documentation for wan feature.
Date: Fri, 22 Sep 2006 12:19:16 +0200
Message-ID: <20060922101945.111263030@datenfreihafen.org>
References: <20060922101913.276298370@datenfreihafen.org>
Reply-To: linux-thinkpad@linux-thinkpad.org
Return-path: <linux-thinkpad-admin@linux-thinkpad.org>
Content-Disposition: inline; filename=ibm-acpi-update-doc-with-wan-feature.patch
Sender: linux-thinkpad-admin@linux-thinkpad.org
Errors-To: linux-thinkpad-admin@linux-thinkpad.org
List-Help: <mailto:linux-thinkpad-request@linux-thinkpad.org?subject=help>
List-Post: <mailto:linux-thinkpad@linux-thinkpad.org>
List-Subscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=subscribe>
List-Unsubscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=unsubscribe>
List-Archive: <http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/>
To: borislav@users.sf.net
Cc: linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org, jeremy@goop.org, multinymous@gmail.com, hmh@hmh.eng.br
List-Id: linux-acpi@vger.kernel.org

Document the wan feature Jeremy Fitzhardinge added to ibm-acpi.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
Index: linux-2.6.18-ibm-acpi/Documentation/ibm-acpi.txt
===================================================================
--- linux-2.6.18-ibm-acpi.orig/Documentation/ibm-acpi.txt	2006-09-21 21:06:04.000000000 +0200
+++ linux-2.6.18-ibm-acpi/Documentation/ibm-acpi.txt	2006-09-21 21:20:52.000000000 +0200
@@ -33,6 +33,7 @@
 	- LCD brightness control
 	- Volume control
 	- Experimental: fan speed, fan enable/disable
+	- Experimental: WAN enable and disable
 
 A compatibility table by model and feature is maintained on the web
 site, http://ibm-acpi.sf.net/. I appreciate any success or failure
@@ -601,6 +602,23 @@
 
 	echo 'level <level>' > /proc/acpi/ibm/thermal
 
+EXPERIMENTAL: WAN -- /proc/acpi/ibm/wan
+---------------------------------------
+
+This feature is marked EXPERIMENTAL because the implementation
+directly accesses hardware registers and may not work as expected. USE
+WITH CAUTION! To use this feature, you need to supply the
+experimental=1 parameter when loading the module.
+
+This feature shows the presence and current state of a WAN (Sierra 
+Wireless EV-DO) device. If WAN is installed, the following commands can 
+be used:
+
+	echo enable > /proc/acpi/ibm/wan
+	echo disable > /proc/acpi/ibm/wan
+
+It was tested on a Lenovo Thinkpad X60. It should probably work on other
+Thinkpad models which come with this module installed.
 
 Multiple Commands, Module Parameters
 ------------------------------------

--

-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
