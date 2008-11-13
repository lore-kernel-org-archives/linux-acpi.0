From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Wed, 12 Nov 2008 20:34:11 -0800
Message-ID: <491BAE43.5080309@zytor.com>
References: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>	<200811081050.25477.arvidjaar@mail.ru> <20081108115956.GE8354@elte.hu>	<4916B38B.7050905@redhat.com> <4916B4DB.90602@zytor.com>	<20081110083938.GD22392@elte.hu>	<20081110115732.GA30181@srcf.ucam.org>	<20081110125630.GC28643@elte.hu>	<20081110130029.GC30894@srcf.ucam.org>	<alpine.LFD.2.00.0811111802440.4480@localhost.localdomain>	<20081112115806.GD11352@elte.hu> <491ACAB9.40203@redhat.com>	<1226546613.4006.110.camel@yakui_zhao.sh.intel.com> <m1vdusnu4d.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:36658 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbYKMEfE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 23:35:04 -0500
In-Reply-To: <m1vdusnu4d.fsf@frodo.ebiederm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Habkost <ehabkost@redhat.com>

Eric W. Biederman wrote:
>=20
> Looking at the coreboot source.  It is indeed defined for Nvidia, SIS=
,
> AMD and several others.
>=20
> A lot of boards use:
> outb(0x02, 0xcf9);
> outb(0x06, 0xcf9);
>=20
> Instead of just writing a plain 6.   I think at least on some machine=
s
> there is a requirement for a low to hight transition.
>=20

That is correct; that is what my patch has, with a 50 =C2=B5s delay in
between (I also don't touch the ~6 bits.)

>=20
> Right.  The only scary question is will a motherboard hang if you wri=
te
> to 0xcf9.  If we don't know of an example where writing to 0xcf9 will=
 prevent
> us from getting to the next reset method then adding a generic 0xcf9 =
is
> safe.
>=20

It would be highly surprising, except possibly on pre-PCI systems, whic=
h
is why my patch skips CF9 if the standard PCI ports are not detected.
Although CF9 isn't defined in the PCI spec, it falls in the PCI
configuration port range.

	-hpa
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
