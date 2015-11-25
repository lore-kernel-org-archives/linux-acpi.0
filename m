From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2 0/2] Add acpi_dev_present
Date: Wed, 25 Nov 2015 21:19:55 +0100
Message-ID: <cover.1448480385.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:45328 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbbKYUUB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2015 15:20:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: devel@acpica.org, Hanjun Guo <guohanjun@huawei.com>, Robert Moore <robert.moore@intel.com>, Mark Brown <broonie@kernel.org>, Hui Wang <hui.wang@canonical.com>, Darren Hart <dvhart@infradead.org>

Hi,

On Tue, Nov 24, 2015 at 12:40:51 +0800, Hanjun Guo wrote:
> I think those IDs already cached, in acpi_init_device_object(),
> INIT_LIST_HEAD(&device->pnp.ids);
> ...
> acpi_set_pnp_ids(handle, &device->pnp, type);
> please see API acpi_device_hid(), so I think you can introduce a API =
with
> acpi_device and HID passed as arguments in scan.c

Thank you for your feedback, I've reworked the patch to iterate over
acpi_bus_id_list instead of walking the namespace.

An alternative approach would have been to traverse the acpi_device
tree but it would have been more code. If you would prefer that over
the solution I've settled on please let me know. It would be useful
for stuff like this to have a function that traverses the acpi_device
tree and invokes a callback for each node, =E0 la acpi_ns_walk_namespac=
e().
Does such a thing exist already? If so I've missed it.


> Will those drivers be loaded before the acpi namespace is scanned?

I verified that all 7 existing users invoke the new API from initcall
level "device". The bus is scanned in initcall level "subsystem",
i.e. earlier. So we're on the safe side here. I added a note in the
kernel-doc that the function may not be called from a subsys_initcall()
or earlier, this will hopefully make it foolproof. (If you feel this is
over the top then just leave it out if/when merging.)


On Tue, Nov 24, 2015 at 15:22:18 +0100, Rafael J. Wysocki wrote:
> I'd prefer that to go to utils.c to be honest, even if the namespace
> needs to be walked.

Done. Since this is not part of ACPICA, would it be okay to merge via
ASoC as requested by Mark Brown?

I've pushed the new version of the series to GitHub for more convenient
reviewing. All driver patches except the one for Mark have acks now:
https://github.com/l1k/linux/commits/acpi_dev_present

Thanks,

Lukas


Lukas Wunner (2):
  ACPI / scan: Fix acpi_bus_id_list bookkeeping
  ACPI / utils: Add acpi_dev_present()

 drivers/acpi/internal.h |  8 ++++++++
 drivers/acpi/scan.c     | 22 +++++++++++++++-------
 drivers/acpi/utils.c    | 31 +++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  2 ++
 4 files changed, 56 insertions(+), 7 deletions(-)

--=20
1.8.5.2 (Apple Git-48)

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
