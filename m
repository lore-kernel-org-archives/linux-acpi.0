From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: "acpi_apic_instance=2" works better
Date: Fri, 02 Jul 2010 08:59:52 +0800
Message-ID: <1278032392.4537.1473.camel@rzhang1-desktop>
References: <AANLkTikdLXKwmD8LmIR0YJNmWTUiuVIit8TwJMrMeUP4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44885 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756827Ab0GBA6p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 20:58:45 -0400
In-Reply-To: <AANLkTikdLXKwmD8LmIR0YJNmWTUiuVIit8TwJMrMeUP4@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Serg Alexv." <agel.selena@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

please file a bug report at 
https://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
if the problem still exists in the latest upstream kernel,
and attach the acpidump output and full dmesg output there.

thanks,
rui

On Thu, 2010-07-01 at 18:36 +0800, Serg Alexv. wrote:
> "acpi_apic_instance=2" works just awesome (-:
> 
> Except i still have this:
> 
> $ dmesg |grep Error
> [    0.206631] ACPI Error (psargs-0359): [CDW1] Namespace lookup
> failure, AE_NOT_FOUND
> [    0.206796] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
> [    0.214270] ACPI Error (psargs-0359): [CDW1] Namespace lookup
> failure, AE_NOT_FOUND
> [    0.214434] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
> [    0.300734] ACPI Error (psargs-0359): [CDW1] Namespace lookup
> failure, AE_NOT_FOUND
> [    0.300896] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
> [    0.301174] ACPI Error (psargs-0359): [CDW1] Namespace lookup
> failure, AE_NOT_FOUND
> [    0.301339] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
> [    0.301607] ACPI Error (psargs-0359): [CDW1] Namespace lookup
> failure, AE_NOT_FOUND
> [    0.301770] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
> [    0.302037] ACPI Error (psargs-0359): [CDW1] Namespace lookup
> failure, AE_NOT_FOUND
> [    0.302200] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
> [    0.302486] ACPI Error (psargs-0359): [CDW1] Namespace lookup
> failure, AE_NOT_FOUND
> [    0.302647] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
> [    0.302931] ACPI Error (psargs-0359): [CDW1] Namespace lookup
> failure, AE_NOT_FOUND
> [    0.303093] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
> [    0.303357] ACPI Error (psargs-0359): [CDW1] Namespace lookup
> failure, AE_NOT_FOUND
> [    0.303519] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
> [    0.303787] ACPI Error (psargs-0359): [CDW1] Namespace lookup
> failure, AE_NOT_FOUND
> [    0.303948] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND
> [23364.464085] iwl3945 0000:06:00.0: Error sending REPLY_LEDS_CMD:
> enqueue_hcmd failed: -5
> 
> Linux opengee 2.6.32-23-generic #37-Ubuntu SMP Fri Jun 11 07:54:58 UTC
> 2010 i686 GNU/Linux
> 


