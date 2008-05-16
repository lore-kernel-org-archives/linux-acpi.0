From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 0/5] pci-acpi: improvement for _OSC evaluation
Date: Fri, 16 May 2008 11:00:05 -0700
Message-ID: <200805161100.06049.jbarnes@virtuousgeek.org>
References: <482BD572.30504@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-156.bluehost.com ([67.222.39.36]:56048 "HELO
	outbound-mail-156.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752547AbYEPSAP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 May 2008 14:00:15 -0400
In-Reply-To: <482BD572.30504@jp.fujitsu.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Wednesday, May 14, 2008 11:17 pm Kenji Kaneshige wrote:
> Hi,
>
> Here are some improvement patches for _OSC evaluation on PCI.
>
> - [PATCH 1/5] pci-acpi: remove duplicate code for _OSC
> - [PATCH 2/5] pci-acpi: use local buffer for _OSC
> - [PATCH 3/5] pci-acpi: add flag to indicate query had been done
> - [PATCH 4/5] pci-acpi: remove unused variable in __pci_osc_support_set
> - [PATCH 5/5] pci-acpi: minor cleanups for _OSC
>
> For details, please see the header of each patch.

These cleanups look nice; Shaohua maybe you could take a look too and 
ack/nack?

Thanks,
Jesse
