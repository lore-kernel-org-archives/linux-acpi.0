From: Borislav Deianov <borislav@users.sf.net>
Subject: Re: [Patch 1/3] ibm-acpi: Get rid of experimental status for brightness and volume.
Date: Tue, 26 Sep 2006 12:20:42 -0700
Message-ID: <20060926192042.GC1971@aero.ensim.com>
References: <20060922101913.276298370@datenfreihafen.org> <20060922101944.340168743@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.ensim.com ([65.164.64.254]:27979 "EHLO aero.ensim.com")
	by vger.kernel.org with ESMTP id S932483AbWIZTU7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Sep 2006 15:20:59 -0400
Content-Disposition: inline
In-Reply-To: <20060922101944.340168743@datenfreihafen.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Schmidt <stefan@datenfreihafen.org>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On Fri, Sep 22, 2006 at 12:19:14PM +0200, Stefan Schmidt wrote:
> The brightness and volume features from ibm-acpi are stable. The experimental
> flag is no more needed.
> 
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

Looks good to me. Len, please apply.

Index: linux-2.6.18-ibm-acpi/drivers/acpi/ibm_acpi.c
===================================================================
--- linux-2.6.18-ibm-acpi.orig/drivers/acpi/ibm_acpi.c	2006-09-21 21:02:41.000000000 +0200
+++ linux-2.6.18-ibm-acpi/drivers/acpi/ibm_acpi.c	2006-09-21 21:03:40.000000000 +0200
@@ -1702,13 +1702,11 @@
 	 .name = "brightness",
 	 .read = brightness_read,
 	 .write = brightness_write,
-	 .experimental = 1,
 	 },
 	{
 	 .name = "volume",
 	 .read = volume_read,
 	 .write = volume_write,
-	 .experimental = 1,
 	 },
 	{
 	 .name = "fan",
