From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [Update][PATCH 3/6] ACPI / hotplug: Fix
 handle_root_bridge_removal()
Date: Wed, 06 Nov 2013 16:21:10 -0700
Message-ID: <1383780070.1847.45.camel@misato.fc.hp.com>
References: <5839747.7HXXGHmMBd@vostro.rjw.lan>
	 <2970389.SeMGM45Qln@vostro.rjw.lan> <6808835.gmCqHn1NaE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6808835.gmCqHn1NaE@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2013-11-04 at 14:33 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is required to do get_device() on the struct acpi_device in
> question before passing it to acpi_bus_hot_remove_device() through
> acpi_os_hotplug_execute(), because acpi_bus_hot_remove_device()
> calls acpi_scan_hot_remove() that does put_device() on that
> object.
> 
> The ACPI PCI root removal routine, handle_root_bridge_removal(),
> doesn't do that, which may lead to premature freeing of the
> device object or to executing put_device() on an object that
> has been freed already.
> 
> Fix this problem by making handle_root_bridge_removal() use
> get_device() as appropriate.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi
