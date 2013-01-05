From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [Alternative 2][PATCH] ACPI / PCI: Set root bridge ACPI handle in advance
Date: Fri, 4 Jan 2013 16:19:52 -0800
Message-ID: <CAE9FiQWzc+tYTnJx96po+dY-3k-Bbv_Sg943jvGJcbGPDLfMmA@mail.gmail.com>
References: <1558789.gX8cmBgyDV@vostro.rjw.lan>
	<1832392.tD5dEjQMy4@vostro.rjw.lan>
	<CAE9FiQVSaC=D-KzSPJaP0=HGRnNgxBYv+S6=PqF_3Li+ihTnEQ@mail.gmail.com>
	<2913597.xNs4ttWDNI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <2913597.xNs4ttWDNI@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jiang Liu <liuj97@gmail.com>, Myron Stowe <myron.stowe@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 4, 2013 at 4:14 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, January 04, 2013 04:03:01 PM Yinghai Lu wrote:
>> On Fri, Jan 4, 2013 at 3:38 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >> --- a/arch/x86/include/asm/pci.h
>> >> +++ b/arch/x86/include/asm/pci.h
>> >> @@ -14,6 +14,7 @@
>> >>  struct pci_sysdata {
>> >>       int             domain;         /* PCI domain */
>> >>       int             node;           /* NUMA node */
>> >> +     void            *acpi_handle;
>> >>  #ifdef CONFIG_X86_64
>> >>       void            *iommu;         /* IOMMU private data */
>> >>  #endif
>> >>
>>
>> acpi_handle is not good name and it is confusing.
>
> Well, what would be a better name in your opinion?
>
> I was going to put that into a #ifdef CONFIG_ACPI / #endif, so what about
> calling it acpi_data?

yes, with #ifdef, you can use acpi_handle type directly.

it is acpi handle for pci_root.

so would call int pci_root_acpi_handle ?

Thanks

Yinghai
