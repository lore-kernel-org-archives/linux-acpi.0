From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 3/4] pinctrl: Add ACPI support
Date: Mon, 4 Apr 2016 16:37:13 +0300
Message-ID: <20160404133713.GA1727@lahna.fi.intel.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <1459424685-26965-4-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459424685-26965-4-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Cristina Ciocan <cristina.ciocan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 31, 2016 at 02:44:44PM +0300, Irina Tirdea wrote:
> Add ACPI support for pin controller properties. These are
> based on ACPI _DSD properties and follow the device tree
> model based on states and node configurations. The states
> are defined as _DSD properties and configuration nodes
> are defined using the _DSD Hierarchical Properties Extension.
> 
> A configuration node supports the generic device tree properties.
> 
> The implementation is based on device tree code from devicetree.c.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Looks good to me. Few minor comments below, though.

> ---
>  Documentation/acpi/pinctrl-properties.txt | 274 +++++++++++++++++++++++++
>  drivers/pinctrl/Makefile                  |   1 +
>  drivers/pinctrl/acpi.c                    | 322 ++++++++++++++++++++++++++++++
>  drivers/pinctrl/acpi.h                    |  32 +++
>  drivers/pinctrl/core.c                    |  26 +++
>  drivers/pinctrl/core.h                    |   2 +
>  6 files changed, 657 insertions(+)
>  create mode 100644 Documentation/acpi/pinctrl-properties.txt
>  create mode 100644 drivers/pinctrl/acpi.c
>  create mode 100644 drivers/pinctrl/acpi.h
> 
> diff --git a/Documentation/acpi/pinctrl-properties.txt b/Documentation/acpi/pinctrl-properties.txt
> new file mode 100644
> index 0000000..e93aaaf
> --- /dev/null
> +++ b/Documentation/acpi/pinctrl-properties.txt
> @@ -0,0 +1,274 @@
> += _DSD Device Properties related to pin controllers =
> +
> +== Introduction ==
> +
> +This document is an extension of the pin control subsystem in Linux [1]
> +and provides a way to describe pin controller properties in ACPI. It is
> +based on the Device Specific Data (_DSD) configuration object [2] that
> +was introduced in ACPI 5.1.
> +
> +Pin controllers are hardware modules that control pins by allowing pin
> +multiplexing and configuration. Pin multiplexing allows using the same
> +physical pins for multiple functions; for example, one pin or group of pins
> +may be used for the I2C bus, SPI bus or as general-purpose GPIO pin. Pin
> +configuration allows setting various properties such as pull-up/down,
> +tri-state, drive-strength, etc.
> +
> +Hardware modules whose signals are affected by pin configuration are
> +designated client devices. For a client device to operate correctly,
> +certain pin controllers must set up certain specific pin configurations.
> +Some client devices need a single static pin configuration, e.g. set up
> +during initialization. Others need to reconfigure pins at run-time,
> +for example to tri-state pins when the device is inactive. Hence, each
> +client device can define a set of named states. Each named state is
> +mapped to a pin controller configuration that describes the pin multiplexing
> +or configuration for that state.
> +
> +In ACPI, each pin controller and each client device is represented as an
> +ACPI device, just like any other hardware module. The pin controller
> +properties are defined using _DSD properties [2] under these devices.
> +The named states are defined using Device Properties UUID [3] under the
> +ACPI client device. The configuration nodes are defined using Hierarchical
> +Properties Extension UUID [4] and are split between the ACPI client device
> +and the pin controller device. The configuration nodes contain properties
> +that describe pin multiplexing or configuration that very similar to the
> +ones used for device tree [5].
> +
> +== Example ==
> +
> +For example, let's consider an accelerometer connected to the I2C bus on
> +a platform with a Baytrail pin controller. The accelerometer uses 2 GPIO
> +pins for I2C (SDA, SCL) and one GPIO pin for interrupt.
> +
> +The name for the pins, groups and functions used are the ones defined in the
> +pin controller driver, in the same way as it is done for device tree [5].
> +
> +For the I2C pins, the pin controller driver defines one group called
> +"i2c5_grp" that can be multiplexed with functions "i2c" or "gpio".
> +In our case, we need to select function "i2c" for group "i2c5_grp" in
> +the ACPI description.
> +
> +For the GPIO pin, the pin controller driver defines the name "GPIO_S5[00]"

BTW, those pin names were changed for Baytrail pinctrl driver so you
should probably do that here also.

> +for the pin with index 0 that we use. We need to configure this pin to
> +pull-down with pull strength of 10000 Ohms. We might also want to disable
> +the bias for the GPIO interrupt pin when entering sleep.
> +
> +Here is an ASL example for this device:
> +
> +  // Pin controller device
> +  Scope (_SB.GPO0)
> +  {
> +      Name (MUX0, Package()
> +      {
> +          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +          Package()
> +          {
> +              Package (2) {"function", "i2c"},
> +              Package (2) {"groups", Package () {"i2c5_grp"}},
> +          }
> +      })
> +
> +      Name (CFG0, Package()
> +      {
> +          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +          Package()
> +          {
> +              Package (2) {"pins", Package () {"GPIO_S5[00]"}},
> +              Package (2) {"bias-pull-down", 10000},
> +          }
> +      })
> +
> +      Name (CFG1, Package()
> +      {
> +          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +          Package()
> +          {
> +              Package (2) {"pins", Package () {"GPIO_S5[00]"}},
> +              Package (2) {"bias-disable", 0},
> +          }
> +      })
> +  }
> +
> +  // Accelerometer device with default pinmux and pinconfig for i2c and
> +  // GPIO pins
> +  Scope (_SB.I2C0)
> +  {
> +      Device (ACL0)
> +      {
> +          Name (_HID, ...)
> +
> +          Method (_CRS, 0, Serialized)
> +          {
> +              Name (RBUF, ResourceTemplate ()
> +              {
> +                  I2cSerialBus (...)
> +                  GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
> +                           "\\_SB.GPO0", 0x00, ResourceConsumer, , ) { 0 }
> +              })
> +              Return (RBUF)
> +          }
> +
> +          Name (_DSD, Package ()
> +          {
> +              ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +              Package ()
> +              {
> +                  Package () {"pinctrl-names", Package() {"default", "sleep"}},
> +                  Package ()
> +                  {
> +                      "pinctrl-0",
> +                      Package()
> +                      {
> +                          "accel-default-mux-i2c",
> +                          "accel-default-cfg-int",
> +                      }
> +                  },
> +                  Package ()
> +                  {
> +                      "pinctrl-1",
> +                      Package()
> +                      {
> +                          "accel-sleep-cfg-int",
> +                      }
> +                  },
> +
> +              },
> +              ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +              Package ()
> +              {
> +                  Package (2) {"accel-default-mux-i2c", "\\_SB.GPO0.MUX0"},
> +                  Package (2) {"accel-default-cfg-int", "\\_SB.GPO0.CFG0"},
> +                  Package (2) {"accel-sleep-cfg-int", "\\_SB.GPO0.CFG1"},
> +              },
> +          })
> +      }
> +  }
> +
> +In the ASL excerpt, the accelerometer device has 2 states:
> +  - a default state with 2 pin configurations:
> +    - a pin multiplexing node for the i2c pins that sets function "i2c"
> +      for the "i2c5_grp" pin group
> +    - a pin configuration node for the GPIO interrupt pin that pull down
> +      the "GPIO_S5[00]" pin and sets a pull strength of 10000 Ohms
> +  - a sleep state with 1 pin configuration:
> +    - a pin configuration node for pin "GPIO_S5[00]" that disables pin
> +    bias
> +
> +== _DSD pinctrl properties format ==
> +
> +=== Pin controller client device states  ===
> +
> +The pinctrl states are defined under the device node they apply to.
> +The format of the pinctrl states is:
> +
> +  Name (_DSD, Package ()
> +  {
> +      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +      Package ()
> +      {
> +          Package () {"pinctrl-names", Package() {statename0, statename1, ...}},
> +          Package () {"pinctrl-0", Package() {cfgname0, cfgname1, ...}},
> +          Package () {"pinctrl-1", Package() {cfgname2, cfgname3, ...}},
> +      }
> +  }
> +
> +  statename - name of the pinctrl device state (e.g.: default, sleep, etc.).
> +              These names are associated with the lists of configurations
> +	      defined below: statename0 defines the name for configuration
> +	      property "pinctrl-0", statename1 defines the name for
> +	      configuration property "pinctrl-1", etc.
> +  cfgname - name for the configuration data-only subnode.
> +
> +=== Pin controller configuration nodes  ===
> +
> +The configuration data-only subnodes are defined using the Hierarchical
> +Properties Extension UUID [4]. Their definition is split between the device
> +node and the pin controller node. The format for these subnodes is:
> +
> +  Scope (DEV0)
> +  {
> +      Name (_DSD, Package ()
> +      {
> +          ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> +          Package ()
> +          {
> +              Package (2) {cfgname0, "\\GPO0.DNP0"},
> +              Package (2) {cfgname1, "\\GPO0.DNP1"},
> +          },
> +      })
> +  }
> +
> +  Scope (GPO0)
> +  {
> +      Name (DPN0, Package()

Maybe we should use node names that relate to the pinctrl subsystem and
not the ones used in the hierarchical properties extension example? I mean
real examples.

> +      {
> +          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +          Package() {...}
> +      })
> +      Name (DPN1, Package()
> +      {
> +          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +          Package() {...}
> +      })
> +  }
> +
> +Each DPN data subnode is a regular _DSD node that uses Device Properties
> +UUID [3]. There are 2 types of subnodes, depending on the properties it
> +contains: pin multiplexing nodes and pin configuration nodes.
> +
> +==== Pin multiplexing nodes  ====
> +
> +The pin multiplexing nodes must contain a property named "function" and
> +define a mux function to be applied to a list of pin groups. The properties
> +supported by this node are the same as for device tree [5]. The name for the
> +pins, groups and functions used are the ones defined in the pin controller
> +driver, in the same way as it is done for device tree [5]. The format for
> +this data subnode is:
> +
> +  Name (DPN0, Package()

Same here.

> +  {
> +      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +          Package()
> +          {
> +              Package (2) {"function", functioname},
> +              Package (2) {"groups", Package () {groupname1, groupname2, ...}},
> +          }
> +  })
> +
> +  functioname - the pinmux function to select.
> +  groups - the list of groups to select with this function
> +
> +==== Pin configuration nodes  ====
> +
> +The pin configuration nodes do not contain a property named "function".
> +They must contain a property named "group" or "pins". They will also
> +contain one or more configuration properties like bias-pull-up,
> +drive-open-drain, etc. The properties supported by this node are the
> +same as for device tree. Standard pinctrl properties are defined in the
> +device tree documentation [5] and in <include/linux/pinctrl/pinconf-generic.h>.
> +Pinctrl drivers may also define their own custom properties. The name for the
> +pins/groups  used are the ones defined in the pin controller driver, in the
> +same way as it is done for device tree [5]. The format for the data subnode is:
> +
> +  Name (DPN0, Package()

And here.

> +  {
> +      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +          Package()
> +          {
> +              Package (2) {"pins", Package () {pin1, pin2, ...}},
> +              Package (2) {configname1, configval1},

These should be enclosed in quotes, like "configname1" and so on.

> +              Package (2) {configname2, configval2},
> +          }
> +  })
> +
> +  pins - list of pins that properties in the node apply to
> +  configname - name of the pin configuration property
> +  configval - value of the pin configuration property
> +
> +== References ==
> +
> +[1] Documentation/pinctrl.txt
> +[2] http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm
> +[3] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
> +[4] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.pdf
> +[5] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index e4bc115..12d3af6 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -6,6 +6,7 @@ obj-y				+= core.o pinctrl-utils.o
>  obj-$(CONFIG_PINMUX)		+= pinmux.o
>  obj-$(CONFIG_PINCONF)		+= pinconf.o
>  obj-$(CONFIG_OF)		+= devicetree.o
> +obj-$(CONFIG_ACPI)		+= acpi.o
>  obj-$(CONFIG_GENERIC_PINCONF)	+= pinconf-generic.o
>  obj-$(CONFIG_PINCTRL_ADI2)	+= pinctrl-adi2.o
>  obj-$(CONFIG_PINCTRL_AS3722)	+= pinctrl-as3722.o
> diff --git a/drivers/pinctrl/acpi.c b/drivers/pinctrl/acpi.c
> new file mode 100644
> index 0000000..bed1d88
> --- /dev/null
> +++ b/drivers/pinctrl/acpi.c
> @@ -0,0 +1,322 @@
> +/*
> + * ACPI integration for the pin control subsystem
> + *
> + * Copyright (c) 2016, Intel Corporation.
> + *
> + * Derived from:
> + *  devicetree.c - Copyright (C) 2012 NVIDIA CORPORATION
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +
> +#include "acpi.h"
> +#include "core.h"
> +#include "pinconf.h"
> +#include "pinctrl-utils.h"
> +
> +/**
> + * struct pinctrl_acpi_map - mapping table chunk parsed from ACPI
> + * @node: list node for struct pinctrl's @fw_maps field
> + * @pctldev: the pin controller that allocated this struct, and will free it
> + * @maps: the mapping table entries
> + */
> +struct pinctrl_acpi_map {
> +	struct list_head node;
> +	struct pinctrl_dev *pctldev;
> +	struct pinctrl_map *map;
> +	unsigned num_maps;
> +};
> +
> +static void acpi_maps_list_dh(acpi_handle handle, void *data)
> +{
> +	/* The address of this function is used as a key. */
> +}
> +
> +static struct list_head *acpi_get_maps(struct device *dev)
> +{
> +	acpi_handle handle = ACPI_HANDLE(dev);
> +	struct list_head *maps;
> +	acpi_status status;
> +
> +	status = acpi_get_data(handle, acpi_maps_list_dh, (void **)&maps);
> +	if (ACPI_FAILURE(status))
> +		return NULL;
> +
> +	return maps;
> +}
> +
> +static void acpi_free_maps(struct device *dev, struct list_head *maps)
> +{
> +	acpi_handle handle = ACPI_HANDLE(dev);
> +
> +	acpi_detach_data(handle, acpi_maps_list_dh);
> +	kfree(maps);
> +}
> +
> +static int acpi_init_maps(struct device *dev)
> +{
> +	acpi_handle handle = ACPI_HANDLE(dev);
> +	struct list_head *maps;
> +	acpi_status status;
> +
> +	maps = kzalloc(sizeof(*maps), GFP_KERNEL);
> +	if (!maps)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(maps);
> +
> +	status = acpi_attach_data(handle, acpi_maps_list_dh, maps);
> +	if (ACPI_FAILURE(status))

This leaks maps.

> +		return -EINVAL;
> +
> +	return 0;
> +}
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
