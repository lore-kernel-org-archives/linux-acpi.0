From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 5/7] x86/pci: add 4 more return param in
	IO_APIC_get_PCI_irq_vector
Date: Mon, 11 May 2009 11:05:27 +0200
Message-ID: <20090511090527.GA20087@elte.hu>
References: <4A01C35C.7060207@kernel.org> <4A01C406.2040303@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A01C406.2040303@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


hm, you broke the build:

drivers/pci/hotplug/ibmphp_core.c: In function =E2=80=98ibmphp_init_dev=
no=E2=80=99:
drivers/pci/hotplug/ibmphp_core.c:165: error: expected identifier befor=
e =E2=80=98&=E2=80=99 token
drivers/pci/hotplug/ibmphp_core.c:166: error: too few arguments to func=
tion =E2=80=98IO_APIC_get_PCI_irq_vector=E2=80=99

	Ingo
