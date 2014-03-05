From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Use pci_device_is_present()
Date: Wed, 05 Mar 2014 01:34:29 +0100
Message-ID: <4033818.pd6BkAIJKt@vostro.rjw.lan>
References: <1505390.MlpMqG8COu@vostro.rjw.lan> <20140304082358.GV5018@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140304082358.GV5018@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, March 04, 2014 10:23:58 AM Mika Westerberg wrote:
> On Mon, Mar 03, 2014 at 01:19:25AM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Make the ACPI-based PCI hotplug (ACPIPHP) code use
> > pci_device_is_present() for checking if devices are present instead
> > of open coding the same thing.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
