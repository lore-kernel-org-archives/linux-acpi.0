From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: [ACPI] ACPI using smp_processor_id in preemptible code
Date: Mon, 10 Jan 2005 09:24:54 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575F05409@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262040AbVAJBZU@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

>I enabled CPU hotplug and preemptible debugging... now I get...
>
>BUG: using smp_processor_id() in preemptible [00000001] code:
>swapper/0
>caller is acpi_processor_idle+0xb/0x235
> [<c020ba28>] smp_processor_id+0xa8/0xc0
> [<c02338ce>] acpi_processor_idle+0xb/0x235
> [<c02338c3>] acpi_processor_idle+0x0/0x235
> [<c02338ce>] acpi_processor_idle+0xb/0x235
> [<c02338c3>] acpi_processor_idle+0x0/0x235
> [<c02338c3>] acpi_processor_idle+0x0/0x235
> [<c02338c3>] acpi_processor_idle+0x0/0x235
> [<c0101115>] cpu_idle+0x75/0x110
> [<c04f5988>] start_kernel+0x158/0x180
> [<c04f5390>] unknown_bootoption+0x0/0x1e0
It doesn't trouble to me. It's in idle thread.

Thanks,
Shaohua
