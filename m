From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 7/7] Who controls brightness functionality: vendor specific or generic video driver
Date: Sat, 19 Apr 2008 12:03:11 +0100
Message-ID: <200804191203.13091.carlos@strangeworlds.co.uk>
References: <1208372572.1784.352.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:59295 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbYDSLDt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Apr 2008 07:03:49 -0400
In-Reply-To: <1208372572.1784.352.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Corentin CHARY <corentincj@iksaif.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>

On Wednesday 16 April 2008 20:02:52 Thomas Renninger wrote:
> Who controls brightness functionality: vendor specific or generic video
> driver
>
> Depending on the capablity of ACPI graphics devices and whether they
> implement all necessary functions so that the generic ACPI video driver can
> control them, decide at driver load time whether a vendor specific device
> driver or the ACPI video driver should control the brighntess
> functionality.
>
> Signed-off-by: Thomas Renninger <trenn@suse.de>

NACK the acer-wmi bit, use the following patch instead (feel free to fold it 
into your superpatch though with my sign-off).

-Carlos
--
acer-wmi: Use ACPI video driver instead of WMI where possible

If the generic ACPI video driver can control the video, then we should hand
off control to it, rather than try to handle it ourselves.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/misc/acer-wmi.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)


diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index dd13a37..0d69bc5 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -1100,6 +1100,14 @@ static int __init acer_wmi_init(void)
 		return -ENODEV;
 	}
 
+	if (acpi_video_support & ACPI_VIDEO_BRIGHTNESS &&
+		!(acpi_video_support & ACPI_VIDEO_FORCE_VENDOR_SPECIFIC) &&
+		has_cap(ACER_CAP_BRIGHTNESS)) {
+		interface->capability &= ~ACER_CAP_BRIGHTNESS;
+		printk(ACER_INFO "Brightness must be controlled by "
+		       "generic video driver\n");
+	}
+
 	if (platform_driver_register(&acer_platform_driver)) {
 		printk(ACER_ERR "Unable to register platform driver.\n");
 		goto error_platform_register;
