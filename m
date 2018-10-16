From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
Date: Tue, 16 Oct 2018 17:35:50 +0300
Message-ID: <CAHp75VcWu_6jco6k5to1x1QNG8Ad893J81TPpTbJkLcqw=RR=g@mail.gmail.com>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 12, 2018 at 2:41 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi guys,
>
> To continue the discussion started by Dmitry [1], this is my proposal
> that I mentioned in my last mail. In short, the idea is that instead
> of trying to extend the support for the currently used struct
> property_set, I'm proposing that we introduce a completely new,
> independent type of fwnode, and replace the struct property_set with
> it. I'm calling the type "software node" here.
>
> The reason for a complete separation of the software nodes from the
> generic property handling code is the need to be able to create the
> nodes independently from the devices that they are bind to.
>
> The way this works is that every node that is created will have a
> kobject registered. That will take care the ref counting for us, and
> also allow us to for example display the properties in sysfs.
>
> There are a few more details in patch 3/5 about the software nodes in
> the commit message.
>
> [1] https://lkml.org/lkml/2018/9/17/1067

In private discussion I brought a concern that we exposed properties
as a part of ABI, but at the same time we have not strict rules which
might lead to ambiguous reading, e.g. there is no type exported and
thus no possibility to tell what kind of property it is.

Examples:
1. 0x1 and 0x1 =E2=80=94 are they of the same type?
2. 0x1 =E2=80=94 is it an array or single value?
3. 0x12345678 =E2=80=94 is it string or hex?
4. 25 =E2=80=94 is it hex or decimal?

Until these will not be solved, better to not to expose properties to users=
pace.

>
> --
> heikki
>
>
> Heikki Krogerus (5):
>   drivers core: Prepare support for multiple platform notifications
>   ACPI / glue: Add acpi_platform_notify() function
>   drivers: base: Introducing software nodes to the firmware node
>     framework
>   device property: Move device_add_properties() to swnode.c
>   device property: Remove struct property_set
>
>  .../ABI/testing/sysfs-devices-software_node   |  27 +
>  drivers/acpi/bus.c                            |   1 -
>  drivers/acpi/glue.c                           |  21 +-
>  drivers/acpi/internal.h                       |   1 -
>  drivers/base/Makefile                         |   2 +-
>  drivers/base/core.c                           |  32 +-
>  drivers/base/property.c                       | 529 +-----------
>  drivers/base/swnode.c                         | 812 ++++++++++++++++++
>  include/linux/acpi.h                          |  10 +
>  include/linux/property.h                      |  12 +
>  10 files changed, 929 insertions(+), 518 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-software_node
>  create mode 100644 drivers/base/swnode.c
>
> --
> 2.19.1
>


--=20
With Best Regards,
Andy Shevchenko
