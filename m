From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] x86/pci: do assign root bus res if _CRS is used
Date: Wed, 20 May 2009 17:10:01 -0700
Message-ID: <86802c440905201710q297ac1ecj4279a780811843b1@mail.gmail.com>
References: <49ED22EC.2040204@kernel.org>
	 <200904291708.52830.bjorn.helgaas@hp.com>
	 <200904300914.22772.bjorn.helgaas@hp.com>
	 <200905081640.12677.bjorn.helgaas@hp.com>
	 <20090520164910.6939b92b@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090520164910.6939b92b@jbarnes-g45>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, Gary Hade <garyhade@us.ibm.com>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-acpi@vger.kernel.org

On Wed, May 20, 2009 at 4:49 PM, Jesse Barnes <jbarnes@virtuousgeek.org=
> wrote:
> On Fri, 8 May 2009 16:40:10 -0600
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>> Did anything happen with this?
>>
>> The longer we wait to make "use_crs" the default, the harder it
>> will be, so I'd like to push ahead.
>
> Here's a patch to make CRS the default. =A0If it looks ok I can push =
it
> into my linux-next branch. =A0I'm all for using reliable data from th=
e
> BIOS. =A0I guess we'll find out fairly quickly if this stuff isn't...
>
> --
> Jesse Barnes, Intel Open Source Technology Center
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kern=
el-parameters.txt
> index 90b3924..8d798bf 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1777,7 +1777,7 @@ and is between 256 and 4096 characters. It is d=
efined in the file
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQ ro=
uting is enabled.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0noacpi =A0 =A0 =A0 =A0 =A0[X86] Do not=
 use ACPI for IRQ routing
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0or for=
 PCI scanning.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_crs =A0 =A0 =A0 =A0 [X86] Use _CRS =
for PCI resource
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nocrs =A0 =A0 =A0 =A0 =A0 [X86] Don't u=
se _CRS for PCI resource
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0alloca=
tion.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0routeirq =A0 =A0 =A0 =A0Do IRQ routing=
 for all PCI devices.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0This i=
s normally done in pci_enable_device(),
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pc=
i_x86.h
> index e60fd3e..010c08c 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -25,7 +25,7 @@
> =A0#define PCI_BIOS_IRQ_SCAN =A0 =A0 =A00x2000
> =A0#define PCI_ASSIGN_ALL_BUSSES =A00x4000
> =A0#define PCI_CAN_SKIP_ISA_ALIGN 0x8000
> -#define PCI_USE__CRS =A0 =A0 =A0 =A0 =A0 0x10000
> +#define PCI_NO_CRS =A0 =A0 =A0 =A0 =A0 =A0 0x10000

PCI_NO_ROOT_CRS is more accurate ?

YH
