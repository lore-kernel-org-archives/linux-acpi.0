From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/6] thermal: add the support for building the generic  thermal as a module
Date: Tue, 29 Apr 2008 03:15:55 -0400
Message-ID: <200804290315.56072.lenb@kernel.org>
References: <1207815114.27304.32.camel@acpi-hp-zz.sh.intel.com> <20080416095931.7855a9e8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59358 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273AbYD2HQW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 03:16:22 -0400
In-Reply-To: <20080416095931.7855a9e8@hyperion.delvare>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi <linux-acpi@vger.kernel.org>

On Wednesday 16 April 2008, Jean Delvare wrote:
> I'd like to see
> drivers/thermal/thermal.c renamed to drivers/thermal/thermal_sys.c -
> but that's something for Len in git.)

>From ff16cab69b6ed621686cf342306785175775152d Mon Sep 17 00:00:00 2001
From: Len Brown <len.brown@intel.com>
Date: Tue, 29 Apr 2008 03:12:17 -0400
Subject: [PATCH] thermal: re-name thermal.c to thermal_sys.c
Organization: Intel Open Source Technology Center

thermal_sys was already the name of the resulting module,
and it is built from  this one source file.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/Makefile                     |    1 -
 drivers/thermal/{thermal.c => thermal_sys.c} |    0 
 2 files changed, 0 insertions(+), 1 deletions(-)
 rename drivers/thermal/{thermal.c => thermal_sys.c} (100%)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 02b6451..31108a0 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -2,5 +2,4 @@
 # Makefile for sensor chip drivers.
 #
 
-thermal_sys-objs	+= thermal.o
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
diff --git a/drivers/thermal/thermal.c b/drivers/thermal/thermal_sys.c
similarity index 100%
rename from drivers/thermal/thermal.c
rename to drivers/thermal/thermal_sys.c
-- 
1.5.5.1.99.gf0ec4

