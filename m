From: Gabriel C <nix.or.die@googlemail.com>
Subject: linux-next: ACPI I/O resource conflicts warning
Date: Fri, 09 May 2008 03:20:26 +0200
Message-ID: <4823A6DA.8010502@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934909AbYEIBUt@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi all ,

I've noticed on linux-next from today the following ACPI warning:

...

[4294023.308622] ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 18 (level, low) -> IRQ 18
[4294023.308622] ACPI: I/O resource  [0x400-0x41f] conflicts with ACPI region SMRG [0x400-0x40f]
[4294023.316478] ACPI: Device needs an ACPI driver

...

dsdt.dsl from my motherboard can be found there:

http://frugalware.org/~crazy/ASUS_P5E-VM_DO/dsdt.dsl

full dmesg:

http://frugalware.org/~crazy/dmesg/DMAR/dmesg

Please let me know if you need more infos.

Best Regards,

Gabriel C
