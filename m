From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 0/8] docking realted fixes
Date: Thu, 22 May 2008 14:33:01 +0800
Message-ID: <1211437981.25221.32.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39247 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753656AbYEVG2Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2008 02:28:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>

docking station releted fixes
patch 1, 2: fix
patch 3, 4, 5: merge bay driver into dock driver. dock driver can handle
battery and bay.
patch 6, 7: make libata work with dock driver
patch 8: cleanup

I tested in a T43 with bay and battery hotplug, please review.

Thanks,
Shaohua

