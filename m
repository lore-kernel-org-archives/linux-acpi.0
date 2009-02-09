From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 1/2] PCI/ACPI: move _OSC code to pci_root.c
Date: Mon, 9 Feb 2009 08:38:30 -0700
Message-ID: <20090209153830.GA19064@ldl.fc.hp.com>
References: <498FD420.9000204@jp.fujitsu.com> <498FD451.9070205@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <498FD451.9070205@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Andrew Patterson <andrew.patterson@hp.com>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

* Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>:
> Move PCI _OSC management code from drivers/pci/pci-acpi.c to
> drivers/acpi/pci_root.c. The benefits are
> 
> - We no longer need struct osc_data and its management code (contents
>   are moved to struct acpi_pci_root). This simplify the code, and we
>   no longer care about kmalloc() failure.
> 
> - We can make pci_acpi_osc_support() be a static function, which is
>   called only from drivers/acpi/pci_root.c.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Reviewed-by: Andrew Patterson <andrew.patterson@hp.com>
> Tested-by: Andrew Patterson <andrew.patterson@hp.com>

Acked-by: Alex Chiang <achiang@hp.com>

Thanks.
