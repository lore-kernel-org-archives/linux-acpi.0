From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] ACPI / scan: Clear match_driver flag in acpi_bus_trim()
Date: Tue, 28 Jan 2014 14:59:38 -0700
Message-ID: <1390946378.1792.514.camel@misato.fc.hp.com>
References: <1737561.u7lWGR6b7C@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1737561.u7lWGR6b7C@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2014-01-27 at 01:16 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drivers should not bind to struct acpi_device objects that
> acpi_bus_trim() has been called for, so make that function
> clear flags.match_driver for those objects.
> 
> If that is not done, an ACPI driver may theoretically try to operate
> a device that is not physically present.
> 
> Fixes: 202317a573b2 (ACPI / scan: Add acpi_device objects for all device nodes in the namespace)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi
