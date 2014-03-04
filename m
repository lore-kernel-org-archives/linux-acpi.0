From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] ACPI / hotplug: Rework deferred execution of
 acpi_device_hotplug()
Date: Tue, 04 Mar 2014 12:53:05 -0700
Message-ID: <1393962785.6784.110.camel@misato.fc.hp.com>
References: <1573287.V189PcUPxA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573287.V189PcUPxA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2014-03-01 at 20:57 +0000, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since the only function executed by acpi_hotplug_execute() is
> acpi_device_hotplug() and it only is called by the ACPI core,
> simplify its definition so that it only takes two arguments, the
> ACPI device object pointer and event code, rename it to
> acpi_hotplug_schedule() and move its header from acpi_bus.h to
> the ACPI core's internal header file internal.h.  Modify the
> definition of acpi_device_hotplug() so that its first argument is
> an ACPI device object pointer and modify the definition of
> struct acpi_hp_work accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The change looks good to me.  I wonder if acpi_hotplug_schedule() should
still be in acpi/osl.c after this change, though.

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi
