From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: ACPI hotplug panic with current git head
Date: Fri, 13 Feb 2009 16:30:03 -0800
Message-ID: <200902131630.04858.jesse.barnes@intel.com>
References: <1231604250.3642.33.camel@localhost.localdomain> <497D1BD7.9000609@jp.fujitsu.com> <498045D1.60005@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <498045D1.60005@jp.fujitsu.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, Grant Grundler <grundler@parisc-linux.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, January 28, 2009 3:47 am Kenji Kaneshige wrote:
> I made several patches to fix the wrong assumption described
> above. It is very difficult for me to check all the code that
> refers pci_bus->self. So I checked include/linux/pci-acpi.h and
> the code under drivers/pci/ only. And I made patches for the code
> like below:
>
>  - The code that clearly chooses host bridge operation or
>    PCI-to-PCI bridge operation based on pci_bus->self.
>
>  - The code that might cause endless loop if pci_bus->self is
>    not NULL on the PCI root bus.

Kenji-san, can you re-send these to my private mail so I can apply them?  
(Outlook/Exchange can't let plain text through without molesting it for some 
reason.)

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
