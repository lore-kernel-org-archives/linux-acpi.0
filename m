From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 0/11]docking realted fixes/cleanup -- takes 4
Date: Wed, 27 Aug 2008 11:14:12 +0800
Message-ID: <1219806852.32665.55.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40969 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbYH0DEb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Aug 2008 23:04:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

=EF=BB=BFDocking station, bay, battery hotplug follows the same princip=
le. we
currently have a lot of duplicate code for each of the hotplug (we
currently don't support battery hotplug yet). The patch series try to
make ACPI dock driver support all above hotplug. This simplified things
and removed a lot of code.

The patches haven't too much changes against my last attempt, just add
one patch (patch 2) and refreshed them against Andi's ACPI latest test
tree.

patch 1, 2: fix a bug. the patch isn't related with follow patches
patch 3: add _LCK method support
patch 4, 5, 6: merge bay driver into dock driver. dock driver can handl=
e
battery and bay.
patch 7, 8: make libata work well with dock driver
patch 9: cleanup
patch 10: fix for eject bay in a dock station. Tested by Holger.
patch 11: added a type for dock, like battery, docking station and
ata_bay as Holger suggested.

I tested in a T61 with bay and battery hotplug, please review. =EF=BB=BF=
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
