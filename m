From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/3] ACPI: move internal core declarations to private header
Date: Sat, 21 Feb 2009 23:21:14 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902212259530.5009@localhost.localdomain>
References: <20090219195009.20619.20334.stgit@bob.kio>
 <20090219195153.20619.89309.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:9038 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbZBVEVR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Feb 2009 23:21:17 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFG00INO9FGN0OH@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 21 Feb 2009 22:21:17 -0600 (CST)
In-reply-to: <20090219195153.20619.89309.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org


On Thu, 19 Feb 2009, Bjorn Helgaas wrote:

> A number of things that shouldn't be exposed outside the ACPI core
> were declared in include/acpi/acpi_drivers.h, where anybody can
> see them.  This patch moves those declarations to a new "ospm.h"
> inside drivers/acpi.

I'm not sure that we're using the same terminology.

In ACPI I usually use the word "core" to refer to everything
that is now under drivers/acpi/acpica/
eg. the ACPI interpreter and the OS agnostic code in ACPICA.

That is why dmesg prints this:

ACPI: Core revision 20090123

I use the word "Linux/ACPI" to refer to everything in
drivers/acpi/* and the ACPI stuff under arch/ etc.

OSPM is supposed to be a generic concept of the OS
controlling power management, and ACPI is supposed to
be a component that allows OSPM to work
on (ACPI-compliant) systems.

I think that the ACPI guys probably invented the term OSPM.
I have heard it used outside an ACPI context only once,
and that was mostly to describe what a non-ACPI system
does to deal with its lack of ACPI...

Sometimes in the context of ACPICA, the OS code is called
the "host OS" (and I generally cringe when this term is used
rather than just saying "Linux") and sometimes it is called OSPM --
ie where the OS policy etc are.

We havn't used the term OSPM in the Linux context much.
We do use the term PM, as in CONFIG_PM though...
I'm not immediately wild about the name ospm.h for some reason.

Anyway, to the content of the patch...

We are sort of in transition WRT hiding private information.

We just finished re-factoring all the ACPICA-specific header
files, resulting in 21 private headers under drivers/acpi/acpica/
and out of include/acpi/

I'm not fond of include/acpi/

Currently it is a bucket for include/acpi/acpi.h
to pick up files, and that is in-turn included
by linux/acpi.h -- which is the file that most of
the kernel should include to talk to ACPI.

I do want things that are private to drivers/acpi/ files
to be in drivers/acpi/, and not in include/acpi/

so i guess I like what you're doing here,
but for some reason i'm not excited about the name "ospm.h",
maybe I"ll sleep on it and it will sound excellent tomorrow...

Len Brown, Intel Open Source Technology Center


> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/acpi/bus.c          |    2 ++
>  drivers/acpi/ospm.h         |   23 +++++++++++++++++++++++
>  drivers/acpi/scan.c         |    2 ++
>  drivers/acpi/sleep.c        |    1 +
>  drivers/acpi/wakeup.c       |    1 +
>  include/acpi/acpi_drivers.h |   23 -----------------------
>  6 files changed, 29 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/acpi/ospm.h
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 765fd1c..0286607 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -39,6 +39,8 @@
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  
> +#include "ospm.h"
> +
>  #define _COMPONENT		ACPI_BUS_COMPONENT
>  ACPI_MODULE_NAME("bus");
>  
> diff --git a/drivers/acpi/ospm.h b/drivers/acpi/ospm.h
> new file mode 100644
> index 0000000..8e54c90
> --- /dev/null
> +++ b/drivers/acpi/ospm.h
> @@ -0,0 +1,23 @@
> +
> +/* --------------------------------------------------------------------------
> +                                  Power Resource
> +   -------------------------------------------------------------------------- */
> +
> +int acpi_device_sleep_wake(struct acpi_device *dev,
> +                           int enable, int sleep_state, int dev_state);
> +int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state);
> +int acpi_disable_wakeup_device_power(struct acpi_device *dev);
> +int acpi_power_get_inferred_state(struct acpi_device *device);
> +int acpi_power_transition(struct acpi_device *device, int state);
> +extern int acpi_power_nocheck;
> +
> +/* --------------------------------------------------------------------------
> +                                  Embedded Controller
> +   -------------------------------------------------------------------------- */
> +int acpi_ec_ecdt_probe(void);
> +int acpi_boot_ec_enable(void);
> +
> +/*--------------------------------------------------------------------------
> +                                  Suspend/Resume
> +  -------------------------------------------------------------------------- */
> +extern int acpi_sleep_init(void);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index c54d7b6..2e00298 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -11,6 +11,8 @@
>  
>  #include <acpi/acpi_drivers.h>
>  
> +#include "ospm.h"
> +
>  #define _COMPONENT		ACPI_BUS_COMPONENT
>  ACPI_MODULE_NAME("scan");
>  #define STRUCT_TO_INT(s)	(*((int*)&s))
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 5192666..e841938 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -21,6 +21,7 @@
>  
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
> +#include "ospm.h"
>  #include "sleep.h"
>  
>  u8 sleep_states[ACPI_S_STATE_COUNT];
> diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
> index 2d34806..58c1f91 100644
> --- a/drivers/acpi/wakeup.c
> +++ b/drivers/acpi/wakeup.c
> @@ -8,6 +8,7 @@
>  #include <acpi/acpi_drivers.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
> +#include "ospm.h"
>  #include "sleep.h"
>  
>  #define _COMPONENT		ACPI_SYSTEM_COMPONENT
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index 4358917..f237ec2 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -85,24 +85,6 @@ acpi_status acpi_get_pci_id(acpi_handle handle, struct acpi_pci_id *id);
>  struct pci_bus *pci_acpi_scan_root(struct acpi_device *device, int domain,
>  				   int bus);
>  
> -/* --------------------------------------------------------------------------
> -                                  Power Resource
> -   -------------------------------------------------------------------------- */
> -
> -int acpi_device_sleep_wake(struct acpi_device *dev,
> -                           int enable, int sleep_state, int dev_state);
> -int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state);
> -int acpi_disable_wakeup_device_power(struct acpi_device *dev);
> -int acpi_power_get_inferred_state(struct acpi_device *device);
> -int acpi_power_transition(struct acpi_device *device, int state);
> -extern int acpi_power_nocheck;
> -
> -/* --------------------------------------------------------------------------
> -                                  Embedded Controller
> -   -------------------------------------------------------------------------- */
> -int acpi_ec_ecdt_probe(void);
> -int acpi_boot_ec_enable(void);
> -
>  /*--------------------------------------------------------------------------
>                                    Dock Station
>    -------------------------------------------------------------------------- */
> @@ -142,9 +124,4 @@ static inline void unregister_hotplug_dock_device(acpi_handle handle)
>  }
>  #endif
>  
> -/*--------------------------------------------------------------------------
> -                                  Suspend/Resume
> -  -------------------------------------------------------------------------- */
> -extern int acpi_sleep_init(void);
> -
>  #endif /*__ACPI_DRIVERS_H__*/
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
