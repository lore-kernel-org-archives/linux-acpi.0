From: "=?ISO-8859-1?Q?Dieter_Sch=F6n?=" <tshinbum@gmail.com>
Subject: expicitly use XT_PIC interrupt for an old device?
Date: Mon, 11 Aug 2008 15:24:45 +0200
Message-ID: <cae665fd0808110624m3c8fe48cp5864d68daba5de76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:28927 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbYHKNYq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Aug 2008 09:24:46 -0400
Received: by yx-out-2324.google.com with SMTP id 8so688556yxm.1
        for <linux-acpi@vger.kernel.org>; Mon, 11 Aug 2008 06:24:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

hi group,

i have to migrate a character device driver for an old synchronus
serial PCI board (Moxa C502/PCI)
from 2.2.something to 2.6.5-smp x86_64.
the problem is, that no interrupts are routed to the driver.
i was able to get interrupts when i used a non-SMP kernel and the
"noapic" boot option.

is there a way to explicitly force the use of the 8259 when i request
an interrupt to get the interrupts for this card not routed via the
APIC?
any pointers are appreciated.

thanks in advance,
dieter
