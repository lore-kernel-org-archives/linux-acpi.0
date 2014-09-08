From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Patch v4 04/16] ACPI: Rename processor_core.c as apic_id.c
Date: Mon, 08 Sep 2014 20:51:31 +0800
Message-ID: <540DA653.2000901@linaro.org>
References: <1409192561-19744-1-git-send-email-jiang.liu@linux.intel.com> <1409192561-19744-5-git-send-email-jiang.liu@linux.intel.com> <1957879.bE3ICM6HKO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1957879.bE3ICM6HKO@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiang Liu <jiang.liu@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Grant Likely <grant.likely@linaro.org>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Gerry, Rafael,

On 2014=E5=B9=B409=E6=9C=8808=E6=97=A5 06:37, Rafael J. Wysocki wrote:
> On Thursday, August 28, 2014 10:22:29 AM Jiang Liu wrote:
>> Now all code in processor_core.c is APIC ID related, so rename it as
>> apic_id.c. Later IOAPIC ID related code will be added into apic_id.c=
=2E
> Actually, I'm not sure about this one.
>
> Renames like this make it difficult to backport things in general
> and kind of break "git blame", so do we have to do that?
>
> What's wrong with leaving the name as is and adding a comment
> about the contents being related to IOAPIC ID?

It will be thankful for not renaming the file into apic_id.c, because a=
pic id is x86 specific,
and platform like ARM will also add some code to get cpu hardware id vi=
a GICC structure
in MADT table in that file, apic id is not a generic name for both x86 =
and ARM, I prefer to
keep it as it is :)

Thanks
Hanjun
