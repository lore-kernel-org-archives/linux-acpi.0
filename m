From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 5/30] ACPI / hotplug / PCI: Unified notify handler for
 hotplug events
Date: Wed, 17 Jul 2013 19:07:02 -0700
Message-ID: <CAE9FiQU99a=BeHCrt0FWSeNs8NORg85C4uwQyY7Ky+-nqaSfxg@mail.gmail.com>
References: <26431283.HJCKsss0rt@vostro.rjw.lan>
	<3718119.FLASu5DBx8@vostro.rjw.lan>
	<2366394.4EoP1MXmG2@vostro.rjw.lan>
	<1551099.EAQDd0lEcY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33237 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab3GRCHD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jul 2013 22:07:03 -0400
In-Reply-To: <1551099.EAQDd0lEcY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

On Wed, Jul 17, 2013 at 4:18 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Using the hotplug context objects introduced previously rework the
> ACPI-based PCI hotplug (ACPIPHP) core code so that all notifications
> for ACPI device objects corresponding to the hotplug PCI devices are
> handled by one function, handle_hotplug_event(), which recognizes
> whether it has to handle a bridge or a function.
>
> In addition to code size reduction it allows some ugly pieces of code
> where notify handlers have to be uninstalled and installed again to
> go away.  Moreover, it fixes a theoretically possible race between
> handle_hotplug_event() and free_bridge() tearing down data structures
> for the same handle.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/hotplug/acpiphp.h      |    1
>  drivers/pci/hotplug/acpiphp_glue.c |  132 ++++++++++++++-----------------------
>  2 files changed, 53 insertions(+), 80 deletions(-)

Can you put this patches in one temp branch ?

Like to check final bits.

Thanks

Yinghai
