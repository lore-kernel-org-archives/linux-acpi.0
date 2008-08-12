From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: expicitly use XT_PIC interrupt for an old device?
Date: Tue, 12 Aug 2008 09:09:22 +0800
Message-ID: <1218503362.6671.143.camel@yakui_zhao.sh.intel.com>
References: <48A053E7.3090305@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36650 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbYHLAzX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 20:55:23 -0400
In-Reply-To: <48A053E7.3090305@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dieter =?ISO-8859-1?Q?Sch=F6n?= <tshinbum@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Mon, 2008-08-11 at 16:59 +0200, Dieter Sch=C3=B6n wrote:
> hi group,
>=20
> i have to migrate a character device driver for an old synchronus
> serial PCI board (Moxa C502/PCI)
> from 2.2.something to 2.6.5-smp x86_64.
> the problem is, that no interrupts are routed to the driver.
> i was able to get interrupts when i used a non-SMP kernel and the
> "noapic" boot option.
>=20
> is there a way to explicitly force the use of the 8259 when i request
> an interrupt to get the interrupts for this card not routed via the
> APIC?
> any pointers are appreciated.
doubt whether the I8259 and I/O APIC can be used at the same time.
When the non-smp kernel is used and boot option of "noapic" is added,
there exists the interrupt for PCI UART card.=20
Do you try it with the boot option of "noapic" on smp kernel?
Can you try it on the latest kernel?
Thanks.
> thanks in advance,
> dieter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
