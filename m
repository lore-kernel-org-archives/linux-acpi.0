From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] ACPI: Additional changes on top of "ACPI / driver core: Store a device pointer in struct acpi_dev_node"
Date: Thu, 14 Nov 2013 00:25:18 +0100
Message-ID: <1803808.ghCmmaO2Cj@vostro.rjw.lan>
References: <3268437.YsusHvklcv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <3268437.YsusHvklcv@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Lan Tianyu <tianyu.lan@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Luck, Tony" <tony.luck@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi Everybody,

The following two patches make changes that in my opinion are worth making on
top of https://patchwork.kernel.org/patch/3167391/ .  The first one simply
replaces DEVICE_ACPI_HANDLE with ACPI_HANDLE everywhere (as the former is now
a simple alias of the latter) and the second one adds ACPI device reference
counting to acpi_bind_one()/acpi_unbind_one() to help catch device removal
ordering issues that would cause the kernel to crash.

Thanks,
Rafael
