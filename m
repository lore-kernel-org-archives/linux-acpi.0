From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v6 0/22] On-demand device probing
Date: Tue, 29 Sep 2015 10:08:16 +0200
Message-ID: <CAAObsKCBOoBZOzyZiqR=mpZwy5u3ZEr2ZE6qFOCedpHug2gHaA@mail.gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com> <5606E120.3070305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33694 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932623AbbI2IIi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Sep 2015 04:08:38 -0400
In-Reply-To: <5606E120.3070305@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On 26 September 2015 at 20:17, Rob Herring <robh@kernel.org> wrote:
> On 09/21/2015 09:02 AM, Tomeu Vizoso wrote:
>> Hello,
>>
>> I have a problem with the panel on my Tegra Chromebook taking longer
>> than expected to be ready during boot (St=C3=A9phane Marchesin repor=
ted what
>> is basically the same issue in [0]), and have looked into ordered
>> probing as a better way of solving this than moving nodes around in =
the
>> DT or playing with initcall levels and linking order.
>>
>> While reading the thread [1] that Alexander Holler started with his
>> series to make probing order deterministic, it occurred to me that i=
t
>> should be possible to achieve the same by probing devices as they ar=
e
>> referenced by other devices.
>>
>> This basically reuses the information that is already implicit in th=
e
>> probe() implementations, saving us from refactoring existing drivers=
 or
>> adding information to DTBs.
>>
>> During review of v1 of this series Linus Walleij suggested that it
>> should be the device driver core to make sure that dependencies are
>> ready before probing a device. I gave this idea a try [2] but Mark B=
rown
>> pointed out to the logic duplication between the resource acquisitio=
n
>> and dependency discovery code paths (though I think it's fairly mino=
r).
>>
>> To address that code duplication I experimented with Arnd's devm_pro=
be
>> [3] concept of having drivers declare their dependencies instead of
>> acquiring them during probe, and while it worked [4], I don't think =
we
>> end up winning anything when compared to just probing devices on-dem=
and
>> from resource getters.
>>
>> One remaining objection is to the "sprinkling" of calls to
>> of_device_probe() in the resource getters of each subsystem, but I t=
hink
>> it's the right thing to do given that the storage of resources is
>> currently subsystem-specific.
>>
>> We could avoid the above by moving resource storage into the core, b=
ut I
>> don't think there's a compelling case for that.
>>
>> I have tested this on boards with Tegra, iMX.6, Exynos, Rockchip and
>> OMAP SoCs, and these patches were enough to eliminate all the deferr=
ed
>> probes (except one in PandaBoard because omap_dma_system doesn't hav=
e a
>> firmware node as of yet).
>>
>> Have submitted a branch [5][6][7] with these patches on top of today=
's
>> linux-next (20150921) to kernelci.org and I don't see any issues tha=
t
>> could be caused by them.
>>
>> With this series I get the kernel to output to the panel in 0.5s,
>> instead of 2.8s.
>
> I think we're pretty close other than some minor comments. I would li=
ke
> to see ack's from Greg and some reviewed-bys from others. The subsyst=
em
> changes are minor and there has been plenty of chance to comment, so =
I
> don't think acks from all subsystems are needed.
>
> Your branch is based on -next. Is there any dependence on something i=
n
> -next? I want to get this into -next soon, but need a branch not base=
d
> on -next. Please send me a pull request with the collected acks and
> minor comments I have addressed.

Great, I'm going to send one more revision rebased on top of v4.3-rc1,
without 21 and with the minor changes you suggested, and once Greg is
happy I can send the pull request.

Thanks,

Tomeu

> Rob
>
>>
>> Regards,
>>
>> Tomeu
>>
>> [0] http://lists.freedesktop.org/archives/dri-devel/2014-August/0665=
27.html
>>
>> [1] https://lkml.org/lkml/2014/5/12/452
>>
>> [2] https://lkml.org/lkml/2015/6/17/305
>>
>> [3] http://article.gmane.org/gmane.linux.ports.arm.kernel/277689
>>
>> [4] https://lkml.org/lkml/2015/7/21/441a
>>
>> [5] https://git.collabora.com/cgit/user/tomeu/linux.git/log/?h=3Don-=
demand-probes-v8
>>
>> [6] http://kernelci.org/boot/all/job/collabora/kernel/v4.3-rc2-2587-=
gf92b0ab33d14/
>>
>> [7] http://kernelci.org/boot/all/job/next/kernel/next-20150921
>>
>> Changes in v6:
>> - Drop bus_type.pre_probe and read the periphid in match() instead a=
s
>>   suggested by Alan Stern.
>> - Merge changes to the regulator subsystem's locking so no reference=
s
>>   are leaked between commits.
>>
>> Changes in v5:
>> - Set the pointer to struct device also for AMBA devices
>> - Unset the pointer to struct device when the platform device is abo=
ut
>>   to be unregistered
>> - Increase the reference count of the device before returning from
>>   of_find_device_by_node()
>> - Move the assignment to device_node->device for AMBA devices to ano=
ther
>>   commit.
>> - Hold a reference to the struct device while it's in use in
>>   of_device_probe().
>> - Use regulator_class' klist of devices instead of regulator_list to
>>   store and lookup regulator devices.
>>
>> Changes in v4:
>> - Added bus.pre_probe callback so the probes of Primecell devices ca=
n be
>>   deferred if their device IDs cannot be yet read because of the clo=
ck
>>   driver not having probed when they are registered. Maybe this goes
>>   overboard and the matching information should be in the DT if ther=
e is
>>   one.
>> - Rename of_platform_probe to of_device_probe
>> - Use device_node.device instead of device_node.platform_dev
>> - Add Kconfig DELAY_DEVICE_PROBES to allow disabling delayed probing=
 in
>>   machines with initcalls that depend on devices probing at a given =
time.
>> - Start processing deferred probes in device_initcall_sync
>> - Also defer probes of AMBA devices registered from the DT as they c=
an
>>   also request resources.
>>
>> Changes in v3:
>> - Set and use device_node.platform_dev instead of reversing the logi=
c to
>>   find the platform device that encloses a device node.
>> - Drop the fwnode API to probe firmware nodes and add OF-only API fo=
r
>>   now. I think this same scheme could be used for machines with ACPI=
,
>>   but I haven't been able to find one that had to defer its probes b=
ecause
>>   of the device probe order.
>>
>> Tomeu Vizoso (22):
>>   driver core: handle -EPROBE_DEFER from bus_type.match()
>>   ARM: amba: Move reading of periphid to amba_match()
>>   of/platform: Point to struct device from device node
>>   of: add function to allow probing a device from a OF node
>>   gpio: Probe GPIO drivers on demand
>>   gpio: Probe pinctrl devices on demand
>>   regulator: core: Remove regulator_list
>>   regulator: core: Probe regulators on demand
>>   drm: Probe panels on demand
>>   drm/tegra: Probe dpaux devices on demand
>>   i2c: core: Probe i2c adapters and devices on demand
>>   pwm: Probe PWM chip devices on demand
>>   backlight: Probe backlight devices on demand
>>   usb: phy: Probe phy devices on demand
>>   clk: Probe clk providers on demand
>>   pinctrl: Probe pinctrl devices on demand
>>   phy: core: Probe phy providers on demand
>>   dma: of: Probe DMA controllers on demand
>>   power-supply: Probe power supplies on demand
>>   driver core: Allow deferring probes until late init
>>   driver core: Start processing deferred probes earlier
>>   of/platform: Defer probes of registered devices
>>
>>  drivers/amba/bus.c                  |  88 ++++++------
>>  drivers/base/Kconfig                |  18 +++
>>  drivers/base/dd.c                   |  35 ++++-
>>  drivers/clk/clk.c                   |   3 +
>>  drivers/dma/of-dma.c                |   3 +
>>  drivers/gpio/gpiolib-of.c           |   5 +
>>  drivers/gpu/drm/drm_panel.c         |   3 +
>>  drivers/gpu/drm/tegra/dpaux.c       |   3 +
>>  drivers/i2c/i2c-core.c              |   4 +
>>  drivers/of/device.c                 |  61 +++++++++
>>  drivers/of/platform.c               |  30 +++--
>>  drivers/phy/phy-core.c              |   3 +
>>  drivers/pinctrl/devicetree.c        |   3 +
>>  drivers/power/power_supply_core.c   |   3 +
>>  drivers/pwm/core.c                  |   3 +
>>  drivers/regulator/core.c            | 257 +++++++++++++++++++++++--=
-----------
>>  drivers/usb/phy/phy.c               |   3 +
>>  drivers/video/backlight/backlight.c |   3 +
>>  include/linux/device.h              |   4 +-
>>  include/linux/of.h                  |   1 +
>>  include/linux/of_device.h           |   3 +
>>  21 files changed, 386 insertions(+), 150 deletions(-)
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
