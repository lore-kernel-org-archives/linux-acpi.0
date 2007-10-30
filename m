From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [2.6.24-rc1 regression] AC adapter state does not change after
 resume
Date: Wed, 31 Oct 2007 00:09:32 +0300
Message-ID: <47279D8C.5040708@gmail.com>
References: <200710302324.52822.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070401020002090108000302"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:24758 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbXJ3VJp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Oct 2007 17:09:45 -0400
Received: by ug-out-1314.google.com with SMTP id z38so200204ugc
        for <linux-acpi@vger.kernel.org>; Tue, 30 Oct 2007 14:09:44 -0700 (PDT)
In-Reply-To: <200710302324.52822.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

This is a multi-part message in MIME format.
--------------070401020002090108000302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrey Borzenkov wrote:
> I suspect new ACPI AC adapter code but have to add some printk's to be sure.
> 
> To reproduce - plug in AC cord, suspend, unplug, resume - kpowersave and sysfs 
> still show AC adapter online. Or other way round.
> 
> -andrey
Please check if this patch helps.

Regards,
Alex.

--------------070401020002090108000302
Content-Type: text/x-diff;
 name="update_ac_state_on_sysfs_read.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="update_ac_state_on_sysfs_read.patch"

ACPI: AC: Update AC state on sysfs read

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ac.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index e03de37..bb618c8 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -91,6 +91,9 @@ static int get_ac_property(struct power_supply *psy,
 			   union power_supply_propval *val)
 {
 	struct acpi_ac *ac = to_acpi_ac(psy);
+
+	if (acpi_ac_get_state(ac))
+		return 0;
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = ac->state;

--------------070401020002090108000302--
