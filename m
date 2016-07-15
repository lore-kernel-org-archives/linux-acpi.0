From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 4/9] acpi/arm64: Add GTDT table parse driver
Date: Fri, 15 Jul 2016 15:45:05 +0800
Message-ID: <CADyBb7sGWizLDy3LtpGpJ9jkchyWHZ2oPfsg6fE1ZE54gn05FA@mail.gmail.com>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
 <1468432402-4872-5-git-send-email-fu.wei@linaro.org> <CAJZ5v0i-1NysCiDFX4ST_uBBeYF2YNzWztgDP=u9a4S1OdpWuw@mail.gmail.com>
 <20160713210857.GA9500@roeck-us.net> <CAJZ5v0jnNqjpcY1CGkHxbJFwX1MuRi-U=jTCKWavMdEH4bKR3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJZ5v0jnNqjpcY1CGkHxbJFwX1MuRi-U=jTCKWavMdEH4bKR3g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Wim
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,


On 14 July 2016 at 05:43, Rafael J. Wysocki <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Jul 13, 2016 at 11:08 PM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
>> On Wed, Jul 13, 2016 at 10:30:37PM +0200, Rafael J. Wysocki wrote:
>>> On Wed, Jul 13, 2016 at 7:53 PM,  <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>> > From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> >
>>> > This patch adds support for parsing arch timer in GTDT,
>>> > provides some kernel APIs to parse all the PPIs and
>>> > always-on info in GTDT and export them.
>>> >
>>> > By this driver, we can simplify arm_arch_timer drivers, and
>>> > separate the ACPI GTDT knowledge from it.
>>> >
>>> > Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> > Signed-off-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> > ---
>>> >  drivers/acpi/Kconfig           |   5 ++
>>> >  drivers/acpi/Makefile          |   1 +
>>> >  drivers/acpi/arm64/Kconfig     |  15 ++++
>>> >  drivers/acpi/arm64/Makefile    |   1 +
>>> >  drivers/acpi/arm64/acpi_gtdt.c | 170 +++++++++++++++++++++++++++++++++++++++++
>>> >  include/linux/acpi.h           |   6 ++
>>> >  6 files changed, 198 insertions(+)
>>> >
>>> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>> > index b7e2e77..1cdc7d2 100644
>>> > --- a/drivers/acpi/Kconfig
>>> > +++ b/drivers/acpi/Kconfig
>>> > @@ -521,4 +521,9 @@ config XPOWER_PMIC_OPREGION
>>> >
>>> >  endif
>>> >
>>> > +if ARM64
>>> > +source "drivers/acpi/arm64/Kconfig"
>>> > +
>>> > +endif
>>> > +
>>> >  endif  # ACPI
>>> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>>> > index 251ce85..1a94ff7 100644
>>> > --- a/drivers/acpi/Makefile
>>> > +++ b/drivers/acpi/Makefile
>>> > @@ -99,5 +99,6 @@ obj-$(CONFIG_ACPI_EXTLOG)     += acpi_extlog.o
>>> >  obj-$(CONFIG_PMIC_OPREGION)    += pmic/intel_pmic.o
>>> >  obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
>>> >  obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
>>> > +obj-$(CONFIG_ARM64)    += arm64/
>>> >
>>> >  video-objs                     += acpi_video.o video_detect.o
>>> > diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
>>> > new file mode 100644
>>> > index 0000000..ff5c253
>>> > --- /dev/null
>>> > +++ b/drivers/acpi/arm64/Kconfig
>>> > @@ -0,0 +1,15 @@
>>> > +#
>>> > +# ACPI Configuration for ARM64
>>> > +#
>>> > +
>>> > +menu "The ARM64-specific ACPI Support"
>>> > +
>>> > +config ACPI_GTDT
>>> > +       bool "ACPI GTDT table Support"
>>>
>>> This should depend on ARM64.
>>>
>>> Also I wonder if it needs to be user-selectable?  Wouldn't it be
>>> better to enable it by default when building for ARM64 with ACPI?
>>>
>> It is currently selected in patch 9, in the watchdog driver's Kconfig
>> entry.
>
> Well, it still doesn't have to be user-selectable for that. :-)

Actually it is also automatically selected by [PATCH v7 6/9]:

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 47352d2..71d5b30 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -8,6 +8,7 @@ config CLKSRC_OF
 config CLKSRC_ACPI
  bool
  select CLKSRC_PROBE
+ select ACPI_GTDT if ARM64

 config CLKSRC_PROBE
  bool


>
>> Not sure if I like that; maybe the watchdog driver should depend
>> on it instead ?
>
> If the watchdog is not the only user of it (and I don't think it is),
> it would be better to arrange things this way.
>

There are two user:
(1) arm_arch_timer(which will select CLKSRC_ACPI if ACPI, then
CLKSRC_ACPI will select ACPI_GTDT if ARM64)
So arm_arch_timer will automatically selecte ACPI_GTDT if ARM64 && ACPI

(2) sbsa_gwdt (which will select ACPI_GTDT if ACPI in [PATCH v7 9/9])
So sbsa_gwdt will automatically selecte ACPI_GTDT if ARM64 && ACPI &&
ARM_ARCH_TIMER

So ACPI_GTDT is automatically selected by both of two users.


But like Timur said before:

maybe we just "selecte ACPI_GTDT if ACPI" for ARM64, because ARM64
require GTDT if we use ACPI.


> Thanks,
> Rafael



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
