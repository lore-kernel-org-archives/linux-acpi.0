From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH v2, 0/7] ACPI / hotplug: Common code for ACPI-based hotplug
Date: Tue, 26 Feb 2013 23:41:33 +0100
Message-ID: <3171747.TOMjvVkWL1@vostro.rjw.lan>
References: <3260206.bhaAobGhpZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3260206.bhaAobGhpZ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Jiang Liu <liuj97@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Sunday, February 17, 2013 04:18:31 PM Rafael J. Wysocki wrote:
> Hi All,
> 
> The following patches introduce common code for ACPI-based hotplug for non-PCI
> devices and modify the container and memory hotplug ACPI drivers to use the new
> code.
> 
> This is based on linux-pm.git/master and regarded as v3.10 material.
> 
> [1/7] Introduce acpi_scan_match_handler() that will be useful going forward.
> [2/7] Introduce common code for ACPI-base device hotplug.
> [3/7] Use the new commot hotplug code in the container driver.
> [4/7] Introduce acpi_scan_handler_matching() that will be useful subsequently.
> [5/7] Introduce user space interface for hotplug profiles.
> [6/7] Make the container driver use the hotplug profiles user space interface.
> [7/7] Make the memory hotplug driver use struct acpi_scan_handler along with
>       the hotplug profiles user space interface.

Following is the second iteration.  It takes all of the updates of patch [2/7]
and the discussion of them into account and fixes the issue with 'enabled'
working inversely in [5/7] spotted by Toshi Kani.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
