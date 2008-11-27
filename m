From: "Sihan Goi" <goister@gmail.com>
Subject: ACPI error on HP dc7800p
Date: Thu, 27 Nov 2008 10:19:12 +0800
Message-ID: <b7bb26000811261819h19bb2792o4b09b0eac62150f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:14753 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbYK0CTN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Nov 2008 21:19:13 -0500
Received: by ti-out-0910.google.com with SMTP id b6so478544tic.23
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2008 18:19:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have a self compiled Linux kernel v2.6.22.19 that has ACPI built
into the kernel. I have tested the kernel in several systems and they
all work. However, on a HP dc7800p, the kernel hangs at the ACPI stage
with the following messages:

ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
*hangs here*

Once I disable ACPI with the kernel parameters acpi=off pci=noacpi,
the kernel boots up ok.

This is a pretty new desktop with a Core2 Vpro CPU so I'm pretty sure
it has ACPI support. What could be the problem here?

-- 
- Goi Sihan
goister@gmail.com
