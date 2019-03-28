From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/3] device property: fwnode_is_compatible() helper
Date: Thu, 28 Mar 2019 11:06:27 +0200
Message-ID: <CAHp75Ve7Q=msCpPSLzeJaNGfJmjU4+qQfz+4gMMsA9Xr16Ao=g@mail.gmail.com>
References: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Biju Das <biju.das@bp.renesas.com>, Hans de Goede <hdegoede@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 27, 2019 at 6:43 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> Basically the helper is just a generic version of the function
> of_device_is_compatible() that should work also with ACPI and
> software nodes.
>
> As the first user for the helper, I'm converting in this series the
> USB role switch code to expect the "compatible" property to have the
> value "usb-role-switch" instead of expecting a boolean property named
> "usb-role-switch". I'm doing the same for the USB Type-C mux code.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> thanks,
>
> Heikki Krogerus (3):
>   device property: Add fwnode_is_compatible() and device_is_compatible()
>     helpers
>   usb: roles: Use the "compatible" property instead of a boolean
>     property
>   usb: typec: mux: Use the "compatible" property instead of a boolean
>     property
>
>  drivers/base/property.c   | 35 +++++++++++++++++++++++++++++++++++
>  drivers/usb/roles/class.c |  2 +-
>  drivers/usb/typec/mux.c   |  8 ++------
>  include/linux/property.h  |  3 +++
>  4 files changed, 41 insertions(+), 7 deletions(-)
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
