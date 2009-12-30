From: NewMaverick <sarthorks@gmail.com>
Subject: "acpi_apic_instance=0" works better
Date: Thu, 31 Dec 2009 02:11:54 +0530
Message-ID: <7a6792140912301241m189685fk4e5081a1e12674b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:39181 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbZL3UmP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 15:42:15 -0500
Received: by pzk1 with SMTP id 1so319358pzk.33
        for <linux-acpi@vger.kernel.org>; Wed, 30 Dec 2009 12:42:15 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello

Here is some DMI info from kernel log:
Dec 31 02:03:02 sarthorks kernel: [   16.717511] ACPI: DMI System Vendor: LENOVO
Dec 31 02:03:02 sarthorks kernel: [   16.717513] ACPI: DMI Product Name: 0769AB2
Dec 31 02:03:02 sarthorks kernel: [   16.717515] ACPI: DMI Product
Version: 3000 N200
Dec 31 02:03:02 sarthorks kernel: [   16.717517] ACPI: DMI Board Name: IEL10
Dec 31 02:03:02 sarthorks kernel: [   16.717518] ACPI: DMI BIOS Vendor: LENOVO
Dec 31 02:03:02 sarthorks kernel: [   16.717520] ACPI: DMI BIOS Date: 12/21/2007

After one and a half years (with regular updates), my hardy started
causing trouble at boot time, and "acpi=off" could fix the trouble.

However, after looking at the logs, i tried this
"acpi_apic_instance=0", and now acpi is on, and there's no problem.
Hope this helps.

Sarthak Parikh
