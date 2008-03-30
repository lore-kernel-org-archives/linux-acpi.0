From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH 3/3] [2.6.25-rc5] Warn user about a BIOS bug in recent asus boards
Date: Sat, 29 Mar 2008 17:43:35 -0700
Message-ID: <86802c440803291743i596678cem4f8ff727f208d2d3@mail.gmail.com>
References: <1205280392.8194.46.camel@linux-2bdv.site>
	 <200803120010.41373.lenb@kernel.org>
	 <200803120140.14243.lenb@kernel.org>
	 <1205300688.2240.47.camel@acpi-hp-zz.sh.intel.com>
	 <1205305945.2240.56.camel@acpi-hp-zz.sh.intel.com>
	 <1205391787.2240.71.camel@acpi-hp-zz.sh.intel.com>
	 <47D99970.4010906@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:36376 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbYC3Anh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Mar 2008 20:43:37 -0400
Received: by rv-out-0910.google.com with SMTP id k20so519400rvb.1
        for <linux-acpi@vger.kernel.org>; Sat, 29 Mar 2008 17:43:35 -0700 (PDT)
In-Reply-To: <47D99970.4010906@freemail.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>

2008/3/13 N=E9meth M=E1rton <nm127@freemail.hu>:
>
>  [    0.715787] ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 16 (level,=
 low) -> IRQ 16
=2E..
>  [   25.037202] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level,=
 low) -> IRQ 16
=2E..
>  [   86.320860] irq 16: nobody cared (try booting with the "irqpoll" =
option)
>  [   86.320860] Pid: 0, comm: swapper Not tainted 2.6.25-rc5 #1
>  [   86.320860]  [<c01578f7>] __report_bad_irq+0x27/0x90
>  [   86.320860]  [<c0157b96>] note_interrupt+0x236/0x270
>  [   86.320860]  [<c0156fa3>] ? handle_IRQ_event+0x53/0x60
>  [   86.320860]  [<c015823a>] handle_fasteoi_irq+0x7a/0xd0
>  [   86.320860]  [<c0106174>] do_IRQ+0x44/0xa0
>  [   86.320860]  [<c0104c66>] common_interrupt+0x2e/0x34
>  [   86.320860]  [<c0119039>] ? finish_task_switch+0x59/0xc0
>  [   86.320860]  [<c0118fe0>] ? finish_task_switch+0x0/0xc0
>  [   86.320860]  [<c03080d6>] schedule+0x2b6/0x470
>  [   86.320860]  [<f892fdae>] ? acpi_processor_idle+0x0/0x436 [proces=
sor]
>  [   86.320860]  [<c0102b65>] cpu_idle+0xb5/0xd0
>  [   86.320860]  [<c030343c>] rest_init+0x5c/0x60
>  [   86.320860]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  [   86.320860] handlers:
>  [   86.320860] [<f8915830>] (yenta_interrupt+0x0/0xe0 [yenta_socket]=
)
>  [   86.320860] [<f8afd3f0>] (via_driver_irq_handler+0x0/0x1c0 [via])
>  [   86.320860] Disabling IRQ #16

wonder if other device is using IRQ #16 too.

can you boot with pci=3Drouteirq to check that?

YH
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
