From: "Roger Critchlow" <rec@elf.org>
Subject: Please send DMI info above to linux-acpi@vger.kernel.org
Date: Tue, 25 Nov 2008 21:39:30 -0700
Message-ID: <66d1c98f0811252039x4c8fcaf1if726fffa951923af@mail.gmail.com>
References: <66d1c98f0811252033i692ed9d7xc92ea0d0d0956e00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:15859 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbYKZEjc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Nov 2008 23:39:32 -0500
Received: by fk-out-0910.google.com with SMTP id 18so246771fkq.5
        for <linux-acpi@vger.kernel.org>; Tue, 25 Nov 2008 20:39:30 -0800 (PST)
In-Reply-To: <66d1c98f0811252033i692ed9d7xc92ea0d0d0956e00@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Booting 2.6.27-10 as Ubuntu 8.10 proposed installed it:

[    0.540741] ACPI: BIOS _OSI(Linux) query ignored
[    0.540744] ACPI: DMI System Vendor: LENOVO
[    0.540746] ACPI: DMI Product Name: 7449F9U
[    0.540748] ACPI: DMI Product Version: ThinkPad X200 Tablet
[    0.540750] ACPI: DMI Board Name: 7449F9U
[    0.540751] ACPI: DMI BIOS Vendor: LENOVO
[    0.540753] ACPI: DMI BIOS Date: 09/09/2008
[    0.540755] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
[    0.540757] ACPI: If "acpi_osi=Linux" works better, please notify
linux-acpi@vger.kernel.org

After adding acpi_osi=Linux to boot command line:

[    0.540751] ACPI: BIOS _OSI(Linux) query honored via cmdline
[    0.540754] ACPI: DMI System Vendor: LENOVO
[    0.540755] ACPI: DMI Product Name: 7449F9U
[    0.540757] ACPI: DMI Product Version: ThinkPad X200 Tablet
[    0.540759] ACPI: DMI Board Name: 7449F9U
[    0.540761] ACPI: DMI BIOS Vendor: LENOVO
[    0.540763] ACPI: DMI BIOS Date: 09/09/2008
[    0.540764] ACPI: Please send DMI info above to linux-acpi@vger.kernel.org

-- rec --
