From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 0/8] docking realted fixes
Date: Fri, 06 Jun 2008 13:22:00 +0800
Message-ID: <1212729720.25188.23.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35655 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbYFFFQf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Jun 2008 01:16:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

Docking station, bay, battery hotplug follows the same principle. we
currently have a lot of duplicate code for each of the hotplug (we
currently don't support battery hotplug yet). The patch series try to
make ACPI dock driver support all above hotplug. This simplified things
and removed a lot of code.

patch 1: fix a bug. the patch isn't related with follow patches
patch 2: add _LCK method support
patch 3, 4, 5: merge bay driver into dock driver. dock driver can handle
battery and bay.
patch 6, 7: make libata work well with dock driver
patch 8: cleanup

I tested in a T43 with bay and battery hotplug, please review.

Thanks,
Shaohua


