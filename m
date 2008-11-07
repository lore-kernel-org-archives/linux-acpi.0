From: "Nolberto Garavelli" <nolberto.garavelli@gmail.com>
Subject: acpi_osi
Date: Fri, 7 Nov 2008 23:09:32 +0100
Message-ID: <67516930811071409t59104c89xb4d01836254b95d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:23980 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbYKGWJe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2008 17:09:34 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1703015fkq.5
        for <linux-acpi@vger.kernel.org>; Fri, 07 Nov 2008 14:09:32 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Added "acpi_osi=Linux" at my /boot/grub/menu.lst:

kernel /boot/vmlinuz26 acpi_osi=Linux
root=/dev/disk/by-uuid/58aa5616-bbe0-4f9f-a77c-ad44f158d16b ro

Nothing seems different.

DMI info:
ACPI: DMI System Vendor: Olidata S.p.A.
ACPI: DMI Product Name: Olidata ST3050
ACPI: DMI Product Version: 20
ACPI: DMI Board Name: L55RIx
ACPI: DMI BIOS Vendor: Phoenix Technologies LTD.
ACPI: DMI BIOS Date: 08/31/07

Regards,
Nolberto
