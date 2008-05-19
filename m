From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 0/5] pci-acpi: improvement for _OSC evaluation
Date: Mon, 19 May 2008 11:29:22 +0800
Message-ID: <1211167762.2836.0.camel@sli10-desk.sh.intel.com>
References: <482BD572.30504@jp.fujitsu.com>
	 <200805161100.06049.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40985 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070AbYESDY4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 May 2008 23:24:56 -0400
In-Reply-To: <200805161100.06049.jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pci@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Fri, 2008-05-16 at 11:00 -0700, Jesse Barnes wrote:
> On Wednesday, May 14, 2008 11:17 pm Kenji Kaneshige wrote:
> > Hi,
> >
> > Here are some improvement patches for _OSC evaluation on PCI.
> >
> > - [PATCH 1/5] pci-acpi: remove duplicate code for _OSC
> > - [PATCH 2/5] pci-acpi: use local buffer for _OSC
> > - [PATCH 3/5] pci-acpi: add flag to indicate query had been done
> > - [PATCH 4/5] pci-acpi: remove unused variable in __pci_osc_support_set
> > - [PATCH 5/5] pci-acpi: minor cleanups for _OSC
> >
> > For details, please see the header of each patch.
> 
> These cleanups look nice; Shaohua maybe you could take a look too and 
> ack/nack?
Looks good. ACKed.

Thanks,
Shaohua

