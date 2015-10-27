From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v6 03/22] of/platform: Point to struct device from device
 node
Date: Tue, 27 Oct 2015 15:48:40 +0100
Message-ID: <CAAObsKBjNZMhKn2bUMmQO8Lvrqfucnf9dXqmbfQ2DbAc6_GvcQ@mail.gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1800338.r1NE3r6BDS@vostro.rjw.lan>
 <CAAObsKA+ky+6XjqQYswdB4K41V0-_kM9bhLwY0RiCT0rm2qSgw@mail.gmail.com>
 <1806288.pmhamH8mKQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1806288.pmhamH8mKQ@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On 24 October 2015 at 15:57, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, October 22, 2015 03:01:45 PM Tomeu Vizoso wrote:
>> On 22 October 2015 at 03:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Monday, September 21, 2015 04:02:43 PM Tomeu Vizoso wrote:
>> >> When adding platform and AMBA devices, set the device node's device
>> >> member to point to it.
>> >>
>> >> This speeds lookups considerably and is safe because we only create one
>> >> of these devices for any given device node.
>> >>
>> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> >> ---
>> >>
>> >> Changes in v5:
>> >> - Set the pointer to struct device also for AMBA devices
>> >> - Unset the pointer to struct device when the platform device is about
>> >>   to be unregistered
>> >> - Increase the reference count of the device before returning from
>> >>   of_find_device_by_node()
>> >>
>> >>  drivers/of/platform.c | 19 ++++++++++---------
>> >>  include/linux/of.h    |  1 +
>> >>  2 files changed, 11 insertions(+), 9 deletions(-)
>> >>
>> >> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> >> index 1001efaedcb8..408d89f1d124 100644
>> >> --- a/drivers/of/platform.c
>> >> +++ b/drivers/of/platform.c
>> >> @@ -32,11 +32,6 @@ const struct of_device_id of_default_bus_match_table[] = {
>> >>       {} /* Empty terminated list */
>> >>  };
>> >>
>> >> -static int of_dev_node_match(struct device *dev, void *data)
>> >> -{
>> >> -     return dev->of_node == data;
>> >> -}
>> >> -
>> >>  /**
>> >>   * of_find_device_by_node - Find the platform_device associated with a node
>> >>   * @np: Pointer to device tree node
>> >> @@ -45,10 +40,10 @@ static int of_dev_node_match(struct device *dev, void *data)
>> >>   */
>> >>  struct platform_device *of_find_device_by_node(struct device_node *np)
>> >>  {
>> >> -     struct device *dev;
>> >> -
>> >> -     dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
>> >> -     return dev ? to_platform_device(dev) : NULL;
>> >> +     if (np->device && np->device->bus == &platform_bus_type &&
>> >> +         get_device(np->device))
>> >> +             return to_platform_device(np->device);
>> >> +     return NULL;
>> >>  }
>> >>  EXPORT_SYMBOL(of_find_device_by_node);
>> >>
>> >> @@ -192,6 +187,8 @@ static struct platform_device *of_platform_device_create_pdata(
>> >>               goto err_clear_flag;
>> >>       }
>> >>
>> >> +     np->device = &dev->dev;
>> >> +
>> >>       return dev;
>> >>
>> >>  err_clear_flag:
>> >> @@ -272,6 +269,8 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>> >>               goto err_free;
>> >>       }
>> >>
>> >> +     node->device = &dev->dev;
>> >> +
>> >>       return dev;
>> >>
>> >>  err_free:
>> >> @@ -476,6 +475,8 @@ static int of_platform_device_destroy(struct device *dev, void *data)
>> >>       if (of_node_check_flag(dev->of_node, OF_POPULATED_BUS))
>> >>               device_for_each_child(dev, NULL, of_platform_device_destroy);
>> >>
>> >> +     dev->of_node->device = NULL;
>> >> +
>> >>       if (dev->bus == &platform_bus_type)
>> >>               platform_device_unregister(to_platform_device(dev));
>> >>  #ifdef CONFIG_ARM_AMBA
>> >> diff --git a/include/linux/of.h b/include/linux/of.h
>> >> index 2194b8ca41f9..eb091be0f8ee 100644
>> >> --- a/include/linux/of.h
>> >> +++ b/include/linux/of.h
>> >> @@ -52,6 +52,7 @@ struct device_node {
>> >>       phandle phandle;
>> >>       const char *full_name;
>> >>       struct fwnode_handle fwnode;
>> >> +     struct device *device;
>> >
>> > There are cases in which multiple device objects point to the same device_node,
>> > so is the single struct device pointer here really sufficient?
>>
>> Only one struct device is registered for a given DT device node when
>> the DT is scanned (otherwise, of_find_device_by_node wouldn't be
>> safe).
>>
>> If some driver makes a struct device to point to a device_node that
>> already has a struct device associated with it, that's fine.
>
> Well, once that has happened, your new device pointer in the given device_node
> becomes useless.  Why exactly is that fine?

Why do you think it's useless? It's the device that was registered
from that device_node. The other one just happens to want to point to
the same device_node for whatever other reason, but I don't see how is
that relevant.

Regards,

Tomeu
