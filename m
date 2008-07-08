From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 0/10]docking realted fixes -- takes 3
Date: Tue, 08 Jul 2008 13:50:18 +0800
Message-ID: <1215496218.17826.33.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44738 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbYGHFnM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 01:43:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>

=EF=BB=BFDocking station, bay, battery hotplug follows the same princip=
le. we
currently have a lot of duplicate code for each of the hotplug (we
currently don't support battery hotplug yet). The patch series try to
make ACPI dock driver support all above hotplug. This simplified things
and removed a lot of code.

patch 1: fix a bug. the patch isn't related with follow patches
patch 2: add _LCK method support
patch 3, 4, 5: merge bay driver into dock driver. dock driver can handl=
e
battery and bay.
patch 6, 7: make libata work well with dock driver
patch 8: cleanup
patch 9: fix for eject bay in a dock station. Tested by Holger.
patch 10: added a type for dock, like battery, docking station and
ata_bay as Holger suggested.

I tested in a T43 with bay and battery hotplug, please review. =EF=BB=BF=
I had a
lot of discussion with Holger and a lot of issues are fixed. hopes this
series can be merged.

Thanks,
Shaohua

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
