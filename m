From: Borislav Deianov <borislav@users.sf.net>
Subject: Re: [Patch 2/3] ibm-acpi: Update documentation for brightness and volume.
Date: Tue, 26 Sep 2006 12:22:34 -0700
Message-ID: <20060926192234.GD1971@aero.ensim.com>
References: <20060922101913.276298370@datenfreihafen.org> <20060922101944.826924436@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.ensim.com ([65.164.64.254]:44626 "EHLO aero.ensim.com")
	by vger.kernel.org with ESMTP id S932484AbWIZTWs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Sep 2006 15:22:48 -0400
Content-Disposition: inline
In-Reply-To: <20060922101944.826924436@datenfreihafen.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Schmidt <stefan@datenfreihafen.org>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On Fri, Sep 22, 2006 at 12:19:15PM +0200, Stefan Schmidt wrote:
> Document the change of the experimental flag for brightness and volume.
> 
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

Looks good to me. Len, please apply.

Borislav


Index: linux-2.6.18-ibm-acpi/Documentation/ibm-acpi.txt
===================================================================
--- linux-2.6.18-ibm-acpi.orig/Documentation/ibm-acpi.txt	2006-09-21 20:56:16.000000000 +0200
+++ linux-2.6.18-ibm-acpi/Documentation/ibm-acpi.txt	2006-09-21 20:59:22.000000000 +0200
@@ -30,8 +30,8 @@
 	- ACPI sounds
 	- temperature sensors
 	- Experimental: embedded controller register dump
-	- Experimental: LCD brightness control
-	- Experimental: volume control
+	- LCD brightness control
+	- Volume control
 	- Experimental: fan speed, fan enable/disable
 
 A compatibility table by model and feature is maintained on the web
@@ -523,13 +523,8 @@
 with this, do send me your results (including some complete dumps with
 a description of the conditions when they were taken.)
 
-EXPERIMENTAL: LCD brightness control -- /proc/acpi/ibm/brightness
------------------------------------------------------------------
-
-This feature is marked EXPERIMENTAL because the implementation
-directly accesses hardware registers and may not work as expected. USE
-WITH CAUTION! To use this feature, you need to supply the
-experimental=1 parameter when loading the module.
+LCD brightness control -- /proc/acpi/ibm/brightness
+---------------------------------------------------
 
 This feature allows software control of the LCD brightness on ThinkPad
 models which don't have a hardware brightness slider. The available
@@ -542,13 +537,8 @@
 The <level> number range is 0 to 7, although not all of them may be
 distinct. The current brightness level is shown in the file.
 
-EXPERIMENTAL: Volume control -- /proc/acpi/ibm/volume
------------------------------------------------------
-
-This feature is marked EXPERIMENTAL because the implementation
-directly accesses hardware registers and may not work as expected. USE
-WITH CAUTION! To use this feature, you need to supply the
-experimental=1 parameter when loading the module.
+Volume control -- /proc/acpi/ibm/volume
+---------------------------------------
 
 This feature allows volume control on ThinkPad models which don't have
 a hardware volume knob. The available commands are:
