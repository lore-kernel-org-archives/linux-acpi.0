From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Use pci_device_is_present()
Date: Tue, 4 Mar 2014 10:23:58 +0200
Message-ID: <20140304082358.GV5018@intel.com>
References: <1505390.MlpMqG8COu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505390.MlpMqG8COu@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 03, 2014 at 01:19:25AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the ACPI-based PCI hotplug (ACPIPHP) code use
> pci_device_is_present() for checking if devices are present instead
> of open coding the same thing.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
