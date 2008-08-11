From: =?ISO-8859-15?Q?Dieter_Sch=F6n?= <tshinbum@gmail.com>
Subject: expicitly use XT_PIC interrupt for an old device?
Date: Mon, 11 Aug 2008 16:59:51 +0200
Message-ID: <48A053E7.3090305@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:19030 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbYHKPAD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Aug 2008 11:00:03 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1816828fkq.5
        for <linux-acpi@vger.kernel.org>; Mon, 11 Aug 2008 08:00:02 -0700 (PDT)
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
