From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC v1 00/11] Split struct irq_data into common part and per-chip
 part
Date: Fri, 15 May 2015 22:57:46 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505152256300.4225@nanos>
References: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43120 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161002AbbEOU6A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2015 16:58:00 -0400
In-Reply-To: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 4 May 2015, Jiang Liu wrote:
> Hi all,
> 	Now the irq core supports hierarchy irq and stacked irqchips,
> so there may be multiple irq_datas associated with the same irq. But
> some fields in struct irq_data are per-irq instance and duplicating
> those fields into multiple irq_data may cause troubles.
> 	So this patch introduces a new data structure 'struct
> irq_common_data' to host per-irq instance data fields, and struct
> irq_data will only host per-chip data fields after the conversion.

I really like that change in general. Please address the few review
comments and resubmit.

Thanks,

	tglx
