From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 0/22] acpi4asus sync with 0.31
Date: Tue, 19 Dec 2006 22:17:43 +0100
Message-ID: <200612192217.43660.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:50219 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933018AbWLSV0M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 16:26:12 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Hi,
This set of patch is against 2.6.19. It add support for many 
models, /sys/class/backlight/, Light Sens, etc ... There is also a lot of 
cleanups. And the most important, a new system to handle unsupported models.

Patch from 0 to 10 are change and cleanups in the driver.
Patch from 11t to 21 add support for new models.

All the following patchs are available here : 
<http://xf.iksaif.net/acpi4asus/2.6.19/>

Thanks
-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net

