From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] acpi: Disable explicit power state retrieval on fans
Date: Tue, 10 Nov 2009 15:09:12 -0500
Message-ID: <1257883752-2163-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34904 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757956AbZKJUJ1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2009 15:09:27 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Matthew Garrett <mjg@redhat.com>

https://bugzilla.redhat.com/show_bug.cgi?id=531916 describes a system
with a _PSC method for the fan that always returns "on". There's no
benefit in us always requesting the state of the fan when performing
transitions - we want to do everything we can to ensure that the fan turns
on when it should do, not risk hardware damage by believing the hardware
when it tells us the fan is already on. Given that the Leading Other OS(tm)
works fine on this machine, it seems likely that it behaves in much this
way.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/fan.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index f419849..835b55e 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -256,6 +256,7 @@ static int acpi_fan_add(struct acpi_device *device)
 		goto end;
 	}
 
+	device->power.flags.explicit_get = 0;
 	device->flags.force_power_state = 1;
 	acpi_bus_set_power(device->handle, state);
 	device->flags.force_power_state = 0;
-- 
1.6.5.2

