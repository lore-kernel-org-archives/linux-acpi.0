From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/2] PCI/ACPI: move _OSC code to pci_root.c
Date: Fri, 13 Feb 2009 13:24:31 -0800
Message-ID: <200902131324.32281.jbarnes@virtuousgeek.org>
References: <498FD420.9000204@jp.fujitsu.com> <498FD451.9070205@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <498FD451.9070205@jp.fujitsu.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Andrew Patterson <andrew.patterson@hp.com>, Alex Chiang <achiang@hp.com>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Sunday, February 8, 2009 10:59 pm Kenji Kaneshige wrote:
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

Applied this series, thanks Kenji-san, Andrew & Alex.

-- 
Jesse Barnes, Intel Open Source Technology Center
