From: "Serg Alexv." <agel.selena@gmail.com>
Subject: "acpi_apic_instance=2" works better
Date: Thu, 1 Jul 2010 14:36:00 +0400
Message-ID: <AANLkTikdLXKwmD8LmIR0YJNmWTUiuVIit8TwJMrMeUP4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58314 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044Ab0GAKgV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jul 2010 06:36:21 -0400
Received: by fxm14 with SMTP id 14so1083428fxm.19
        for <linux-acpi@vger.kernel.org>; Thu, 01 Jul 2010 03:36:20 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

"acpi_apic_instance=2" works just awesome (-:

Except i still have this:

$ dmesg |grep Error
[    0.206631] ACPI Error (psargs-0359): [CDW1] Namespace lookup
failure, AE_NOT_FOUND
[    0.206796] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
[    0.214270] ACPI Error (psargs-0359): [CDW1] Namespace lookup
failure, AE_NOT_FOUND
[    0.214434] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
[    0.300734] ACPI Error (psargs-0359): [CDW1] Namespace lookup
failure, AE_NOT_FOUND
[    0.300896] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
[    0.301174] ACPI Error (psargs-0359): [CDW1] Namespace lookup
failure, AE_NOT_FOUND
[    0.301339] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
[    0.301607] ACPI Error (psargs-0359): [CDW1] Namespace lookup
failure, AE_NOT_FOUND
[    0.301770] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
[    0.302037] ACPI Error (psargs-0359): [CDW1] Namespace lookup
failure, AE_NOT_FOUND
[    0.302200] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
[    0.302486] ACPI Error (psargs-0359): [CDW1] Namespace lookup
failure, AE_NOT_FOUND
[    0.302647] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
[    0.302931] ACPI Error (psargs-0359): [CDW1] Namespace lookup
failure, AE_NOT_FOUND
[    0.303093] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
[    0.303357] ACPI Error (psargs-0359): [CDW1] Namespace lookup
failure, AE_NOT_FOUND
[    0.303519] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
[    0.303787] ACPI Error (psargs-0359): [CDW1] Namespace lookup
failure, AE_NOT_FOUND
[    0.303948] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
[23364.464085] iwl3945 0000:06:00.0: Error sending REPLY_LEDS_CMD:
enqueue_hcmd failed: -5

Linux opengee 2.6.32-23-generic #37-Ubuntu SMP Fri Jun 11 07:54:58 UTC
2010 i686 GNU/Linux

-- 
best, aj.
