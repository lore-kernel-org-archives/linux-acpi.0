From: Borislav Deianov <borislav@users.sf.net>
Subject: Re: [Patch 3/3] ibm-acpi: Add documentation for wan feature.
Date: Tue, 26 Sep 2006 12:24:33 -0700
Message-ID: <20060926192433.GE1971@aero.ensim.com>
References: <20060922101913.276298370@datenfreihafen.org> <20060922101945.111263030@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.ensim.com ([65.164.64.254]:60462 "EHLO aero.ensim.com")
	by vger.kernel.org with ESMTP id S932486AbWIZTYj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Sep 2006 15:24:39 -0400
Content-Disposition: inline
In-Reply-To: <20060922101945.111263030@datenfreihafen.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Schmidt <stefan@datenfreihafen.org>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On Fri, Sep 22, 2006 at 12:19:16PM +0200, Stefan Schmidt wrote:
> Document the wan feature Jeremy Fitzhardinge added to ibm-acpi.
> 
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

Looks good to me. Len, please apply.

Borislav

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
