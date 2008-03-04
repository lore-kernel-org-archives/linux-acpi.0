From: akpm@linux-foundation.org
Subject: [patch 3/5] acpi: make real parent for ACPI button input devices
Date: Tue, 04 Mar 2008 15:06:35 -0800
Message-ID: <200803042306.m24N6ZGA001810@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39783 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934583AbYCDXIs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 18:08:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, arvidjaar@mail.ru, dtor@mail.ru

From: Andrey Borzenkov <arvidjaar@mail.ru>

Make sure input device for ACPI button gets proper place in device tree.

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Len Brown <lenb@kernel.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/button.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/acpi/button.c~acpi-make-real-parent-for-acpi-button-input-devices drivers/acpi/button.c
--- a/drivers/acpi/button.c~acpi-make-real-parent-for-acpi-button-input-devices
+++ a/drivers/acpi/button.c
@@ -449,6 +449,7 @@ static int acpi_button_add(struct acpi_d
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
 	input->id.product = button->type;
+	input->dev.parent = &device->dev;
 
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWER:
_
