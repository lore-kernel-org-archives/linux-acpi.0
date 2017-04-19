From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4 2/2] ACPI / PMIC: Stop xpower OPRegion handler
 relying on IIO
Date: Wed, 19 Apr 2017 13:41:07 -0700
Message-ID: <1492634467.69096.251.camel@linux.intel.com>
References: <20170419130700.31277-1-hdegoede@redhat.com>
         <20170419130700.31277-3-hdegoede@redhat.com>
         <CAJZ5v0i6SztwFrkGA3cw9Y+qCGuJ_mH_gMBXbXx9SgGMRQjHfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:54268 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764621AbdDSUlK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Apr 2017 16:41:10 -0400
In-Reply-To: <CAJZ5v0i6SztwFrkGA3cw9Y+qCGuJ_mH_gMBXbXx9SgGMRQjHfA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>

On Wed, 2017-04-19 at 22:18 +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 19, 2017 at 3:07 PM, Hans de Goede <hdegoede@redhat.com>
> wrote:
> > 
> > The intel_pmic_xpower code provides an OPRegion handler, which must
> > be
> > available before other drivers using it are loaded, which can only
> > be
> > ensured if both the mfd and opregion drivers are built in, which is
> > why
> > the Kconfig option for intel_pmic_xpower is a bool.
> > 
> > The use of IIO is causing trouble for generic distro configs here
> > as
> > distros will typically want to build IIO drivers as modules and
> > there
> > really is no reason to use IIO here. The reading of the ADC value
> > is a
> > single regmap_bulk_read, which is already protected against races
> > by
> > the regmap-lock.
> > 
> > This commit removes the use of IIO, allowing distros to enable the
> > driver without needing to built IIO in and also actually simplifies
> > the code.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Andy, Srinivas, any concerns?
Added Jacob. 
If regmap_bulk_read is protected, we don't need to go through IIO. So
change looks fine to me.

Thanks,
Srinivas
> 
> > 
> > ---
> >  drivers/acpi/Kconfig                  |  2 +-
> >  drivers/acpi/pmic/intel_pmic_xpower.c | 21 ++++-----------------
> >  2 files changed, 5 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index 4f12fe0..842530f 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -506,7 +506,7 @@ config CRC_PMIC_OPREGION
> > 
> >  config XPOWER_PMIC_OPREGION
> >         bool "ACPI operation region support for XPower AXP288 PMIC"
> > -       depends on AXP288_ADC = y
> > +       depends on MFD_AXP20X_I2C
> >         help
> >           This config adds ACPI operation region support for XPower
> > AXP288 PMIC.
> > 
> > diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c
> > b/drivers/acpi/pmic/intel_pmic_xpower.c
> > index e6e991a..55f5111 100644
> > --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> > +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> > @@ -18,7 +18,6 @@
> >  #include <linux/mfd/axp20x.h>
> >  #include <linux/regmap.h>
> >  #include <linux/platform_device.h>
> > -#include <linux/iio/consumer.h>
> >  #include "intel_pmic.h"
> > 
> >  #define XPOWER_GPADC_LOW       0x5b
> > @@ -186,28 +185,16 @@ static int
> > intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
> >   * @regmap: regmap of the PMIC device
> >   * @reg: register to get the reading
> >   *
> > - * We could get the sensor value by manipulating the HW regs here,
> > but since
> > - * the axp288 IIO driver may also access the same regs at the same
> > time, the
> > - * APIs provided by IIO subsystem are used here instead to avoid
> > problems. As
> > - * a result, the two passed in params are of no actual use.
> > - *
> >   * Return a positive value on success, errno on failure.
> >   */
> >  static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap,
> > int reg)
> >  {
> > -       struct iio_channel *gpadc_chan;
> > -       int ret, val;
> > -
> > -       gpadc_chan = iio_channel_get(NULL, "axp288-system-temp");
> > -       if (IS_ERR_OR_NULL(gpadc_chan))
> > -               return -EACCES;
> > +       u8 buf[2];
> > 
> > -       ret = iio_read_channel_raw(gpadc_chan, &val);
> > -       if (ret < 0)
> > -               val = ret;
> > +       if (regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, 2))
> > +               return -EIO;
> > 
> > -       iio_channel_release(gpadc_chan);
> > -       return val;
> > +       return (buf[0] << 4) + ((buf[1] >> 4) & 0x0F);
> >  }
> > 
> >  static struct intel_pmic_opregion_data
> > intel_xpower_pmic_opregion_data = {
> > --
> > 2.9.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
