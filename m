From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 0/3] device property: fwnode_is_compatible() helper
Date: Thu, 28 Mar 2019 19:38:57 +0200
Message-ID: <20190328173857.GC9993@kuha.fi.intel.com>
References: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Biju Das <biju.das@bp.renesas.com>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 27, 2019 at 07:43:36PM +0300, Heikki Krogerus wrote:
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

Don't take this series yet. We are having a discussion on whether this
is the correct approach with the USB mux or not in an other mail
thread. The helper itself (patch 1/3) I guess is fine though.


thanks,

-- 
heikki
