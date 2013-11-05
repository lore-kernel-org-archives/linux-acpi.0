From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [Update][PATCH 1/6] ACPI / scan: Start matching drivers after
 trying scan handlers
Date: Tue, 05 Nov 2013 16:27:41 -0700
Message-ID: <1383694061.1847.13.camel@misato.fc.hp.com>
References: <5839747.7HXXGHmMBd@vostro.rjw.lan>
	 <2970389.SeMGM45Qln@vostro.rjw.lan> <2151922.M630KK6nC3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <2151922.M630KK6nC3@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2013-11-04 at 14:30 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ACPI scan handlers should always be attached to struct acpi_device
> objects before any ACPI drivers, but there is a window during which
> a driver may be attached to a struct acpi_device before checking if
> there is a matching scan handler.  Namely, that will happen if an
> ACPI driver module is loaded during acpi_bus_scan() right after
> the first namespace walk is complete and before the given device
> is processed by the second namespace walk.
> 
> To prevent that from happening, set the match_driver flags of
> struct acpi_device objects right before running device_attach()
> for them in acpi_bus_device_attach().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi
