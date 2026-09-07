Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560941A551;
	Mon,  7 Sep 2026 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782732; cv=none; b=Oa5CX+te56mDKuMsGWGICURK2O2bV9WnBBTQe+LwI4mjZ4ym7srFLCspb1ybZjsSHOmPWLlfCLbdKvsEaz4gUB6Wu4t9CD4lqSxnhdXtQb1flMWFxJ+deoun9GW2ogWuaZ15PaArN669/TjCcdaVFz2bDHDJeE+Ctvg7hoSeY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782732; c=relaxed/simple;
	bh=nBOw5KMEnNUXRYpKwfcK2ytyOLkjWpMUdImYCkuggLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOUaje9pXhmoLW8LN81djAN4/YNk34144acZ+iOBsxfJeAYGU2SZ0erAauQm4asxLaJZVgI2aaXXJFQLL4vqe/0dgPcJRZ5N9CPx7BF1BVr3tOFSBDJ1tfrSf1J5ux0N7IksG8hXux5YONMM2p3Y/sNYMb6Lut7pA8NwJseHQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkKDCiMI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkKDCiMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788782731; x=1820318731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nBOw5KMEnNUXRYpKwfcK2ytyOLkjWpMUdImYCkuggLo=;
  b=OkKDCiMIpUXwuh7MB/L7nff41WZX2aC7Q0rJ52YzeSXVjyu3XNiHHuvV
   cPGGTA+WybPn/gyEo35lFQCuexupRn4/YKZqmO9/pZipusnzVMR79AcDB
   uoX6rYjqxx1lJGU+yi3ddOUK0lfIZQPqBrg42nQfFMAGLVobrh3Sbf3gw
   c3r8Z2nGKOnza/g0VdEvMR74DyC9nO5ZS2fs3wrouFMyWkZT7kxtAubKC
   0NjQ6rNQqsZP9P6UAkApUmtrBLXJZa7sh8HpgJ9rZWhNTbZ4aTr/Tdacp
   WjcoVUbgGIQTfNSoaMzZV767KkXtQOTBVKZPHDl15BmEbjOwYJcgn2oX+
   w==;
X-CSE-ConnectionGUID: nTQPLjKQQ/6PaQkgEOHZHg==
X-CSE-MsgGUID: D8h0rm1jTwSdzNDetMdMTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="99518645"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="99518645"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 05:05:31 -0700
X-CSE-ConnectionGUID: nSuGNdrFRT6yqqJl18g8cQ==
X-CSE-MsgGUID: d/YeiH8UQbSjxprguIVMfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="268115157"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 07 Sep 2026 05:05:28 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id A76C099; Mon, 07 Sep 2026 14:05:26 +0200 (CEST)
Date: Mon, 7 Sep 2026 14:05:26 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Edward Blair <edward.blair@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
	rafael@kernel.org, lenb@kernel.org, mika.westerberg@linux.intel.com,
	gregkh@linuxfoundation.org, W_Armin@gmx.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: typec: ucsi: add ITE885x I2C transport driver
Message-ID: <ap6ohv5oM4Ze9dzz@black.igk.intel.com>
References: <20260829145516.13500-1-edward.blair@gmail.com>
 <20260829145516.13500-3-edward.blair@gmail.com>
 <apavoDwVFw_FKRNd@black.igk.intel.com>
 <CAJDQNgjq-oxQkdYK+fTSd5AHMjM-qTcSPo+s2-+W=Pcn7jYr-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDQNgjq-oxQkdYK+fTSd5AHMjM-qTcSPo+s2-+W=Pcn7jYr-g@mail.gmail.com>

On Tue, Sep 01, 2026 at 01:03:50PM +0100, Edward Blair wrote:
> Thanks,
> 
> I will add the explicit includes and use guard(mutex) for event_lock.
> 
> I kept the explicit IRQ handling because ucsi_resume() queues work which
> issues UCSI commands. If the callbacks are moved to the noirq phase,
> that work can run before the parent I2C controller's resume_early or
> resume callback, while the controller may still be unavailable.

Okay, got it.

> The current ordering disables the device IRQ before quiescing UCSI, then
> re-enables it during normal resumption after the I2C bus has resumed. Does
> that address your concern, or would it be preferable the IRQ and UCSI
> handling to be split across separate PM phases?

I'm sure it's fine as it is now.

Thanks,

> Thanks,
> Edward
> 
> On Tue, 1 Sept 2026 at 11:57, Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Sat, Aug 29, 2026 at 03:55:16PM +0100, Edward Blair wrote:
> > > Add a UCSI transport driver for ITE8853 and ITE8800 through ITE8805
> > > USB Type-C controllers found on desktop motherboards.
> > >
> > > These controllers expose CCI, MESSAGE_IN and CONTROL at ITE-specific I2C
> > > offsets and signal UCSI and vendor events through a shared interrupt
> > > status register. Read and cache each complete UCSI event before
> > > acknowledging it so command data remains coherent between the interrupt
> > > handler and UCSI core.
> > >
> > > The interface does not expose a VERSION register and does not accept
> > > PPM_RESET over I2C. Report UCSI 1.0, limit MESSAGE_IN to its 16-byte
> > > window and handle PPM_RESET locally, matching the vendor driver's
> > > behavior.
> > >
> > > Signed-off-by: Edward Blair <edward.blair@gmail.com>
> > > ---
> > >  drivers/usb/typec/ucsi/Kconfig    |  11 +
> > >  drivers/usb/typec/ucsi/Makefile   |   1 +
> > >  drivers/usb/typec/ucsi/ucsi_ite.c | 395 ++++++++++++++++++++++++++++++
> > >  3 files changed, 407 insertions(+)
> > >  create mode 100644 drivers/usb/typec/ucsi/ucsi_ite.c
> > >
> > > diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> > > index 87dd992a4..3819c4f73 100644
> > > --- a/drivers/usb/typec/ucsi/Kconfig
> > > +++ b/drivers/usb/typec/ucsi/Kconfig
> > > @@ -104,4 +104,15 @@ config UCSI_HUAWEI_GAOKUN
> > >         To compile the driver as a module, choose M here: the module will be
> > >         called ucsi_huawei_gaokun.
> > >
> > > +config UCSI_ITE
> > > +     tristate "UCSI Interface Driver for ITE885x"
> > > +     depends on ACPI && I2C
> > > +     help
> > > +       This driver enables UCSI support on platforms that expose an ITE8853
> > > +       or ITE8800-ITE8805 USB Type-C controller over I2C, commonly found
> > > +       on ASUS Z690/Z790/X670E motherboards.
> > > +
> > > +       To compile the driver as a module, choose M here: the module will be
> > > +       called ucsi_ite.
> > > +
> > >  endif
> > > diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> > > index c7e38bf01..9bc1d6bbb 100644
> > > --- a/drivers/usb/typec/ucsi/Makefile
> > > +++ b/drivers/usb/typec/ucsi/Makefile
> > > @@ -28,3 +28,4 @@ obj-$(CONFIG_UCSI_PMIC_GLINK)               += ucsi_glink.o
> > >  obj-$(CONFIG_CROS_EC_UCSI)           += cros_ec_ucsi.o
> > >  obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)  += ucsi_yoga_c630.o
> > >  obj-$(CONFIG_UCSI_HUAWEI_GAOKUN)     += ucsi_huawei_gaokun.o
> > > +obj-$(CONFIG_UCSI_ITE)                       += ucsi_ite.o
> > > diff --git a/drivers/usb/typec/ucsi/ucsi_ite.c b/drivers/usb/typec/ucsi/ucsi_ite.c
> > > new file mode 100644
> > > index 000000000..16b22c77f
> > > --- /dev/null
> > > +++ b/drivers/usb/typec/ucsi/ucsi_ite.c
> > > @@ -0,0 +1,395 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * UCSI I2C transport driver for ITE885x USB-C controllers
> > > + *
> > > + * ITE8853/ITE8800-ITE8805 are UCSI-compliant USB-C controllers found on
> > > + * desktop motherboards. They communicate over I2C using UCSI registers at
> > > + * ITE-specific offsets and signal events through a vendor interrupt register.
> > > + */
> > > +
> > > +#include <linux/acpi.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> >
> > We need to include everything instead of relying on nested headers
> > nowadays.
> >
> >         linux/device.h
> >         linux/device/devres.h
> >         linux/dev_printk.h
> >         linux/pm.h
> >         linux/string.h
> >
> > > +static int ucsi_ite_process_event(struct ucsi_ite *ite, u32 *cci)
> > > +{
> > > +     u8 message_in[ITE_MESSAGE_IN_MAX_LEN] = {};
> > > +     __le32 raw_cci;
> > > +     u8 status;
> > > +     u8 len = 0;
> > > +     int event;
> > > +     int err = 0;
> > > +     int ret;
> > > +
> > > +     mutex_lock(&ite->event_lock);
> >
> > guard(mutex)(@ite->event_lock);
> >
> > > +     ret = ucsi_ite_read(ite, ITE_REG_INT_STATUS, &status, sizeof(status));
> > > +     if (ret)
> > > +             goto out_unlock;
> > > +
> > > +     status &= ITE_INT_MASK;
> > > +     if (!status) {
> > > +             mutex_lock(&ite->received_lock);
> > > +             *cci = ite->cci;
> > > +             mutex_unlock(&ite->received_lock);
> > > +             ret = ITE_EVENT_NONE;
> > > +             goto out_unlock;
> > > +     }
> > > +
> > > +     if (status & ITE_INT_CCI) {
> > > +             err = ucsi_ite_read(ite, ITE_REG_CCI, &raw_cci,
> > > +                                 sizeof(raw_cci));
> > > +             if (!err) {
> > > +                     *cci = le32_to_cpu(raw_cci);
> > > +                     len = UCSI_CCI_LENGTH(*cci);
> > > +
> > > +                     if (len > sizeof(message_in)) {
> > > +                             len = sizeof(message_in);
> > > +                             *cci &= ~GENMASK(15, 8);
> > > +                             *cci |= UCSI_SET_CCI_LENGTH(len);
> > > +                     }
> > > +                     if (len) {
> > > +                             err = ucsi_ite_read(ite, ITE_REG_MESSAGE_IN,
> > > +                                                 message_in, len);
> > > +                     }
> > > +             }
> > > +     }
> > > +
> > > +     /* Acknowledge each latched event with the value expected by the PPM. */
> > > +     if (status & ITE_INT_VENDOR_ALERT) {
> > > +             u8 ack = ITE_INT_VENDOR_ALERT;
> > > +
> > > +             ret = ucsi_ite_write(ite, ITE_REG_INT_ACK, &ack, sizeof(ack));
> > > +             if (ret)
> > > +                     goto out_unlock;
> > > +     }
> > > +
> > > +     if ((status & ITE_INT_CCI) && !err) {
> > > +             u8 ack = ITE_INT_CCI;
> > > +
> > > +             ret = ucsi_ite_write(ite, ITE_REG_INT_ACK, &ack, sizeof(ack));
> > > +             if (ret)
> > > +                     goto out_unlock;
> > > +     }
> > > +
> > > +     if (err) {
> > > +             ret = err;
> > > +             goto out_unlock;
> > > +     }
> > > +
> > > +     if (status & ITE_INT_CCI) {
> > > +             mutex_lock(&ite->received_lock);
> > > +             ite->cci = *cci;
> > > +             memset(ite->message_in, 0, sizeof(ite->message_in));
> > > +             memcpy(ite->message_in, message_in, len);
> > > +             mutex_unlock(&ite->received_lock);
> > > +             event = ITE_EVENT_CCI;
> > > +     } else {
> > > +             mutex_lock(&ite->received_lock);
> > > +             *cci = ite->cci;
> > > +             mutex_unlock(&ite->received_lock);
> > > +             event = ITE_EVENT_VENDOR;
> > > +     }
> > > +
> > > +     ret = event;
> > > +
> > > +out_unlock:
> > > +     mutex_unlock(&ite->event_lock);
> > > +     return ret;
> > > +}
> >
> > > +static int ucsi_ite_suspend(struct device *dev)
> > > +{
> > > +     struct ucsi_ite *ite = dev_get_drvdata(dev);
> > > +     int ret;
> > > +
> > > +     disable_irq(ite->client->irq);
> > > +     ret = ucsi_suspend(ite->ucsi);
> > > +     if (ret)
> > > +             enable_irq(ite->client->irq);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int ucsi_ite_resume(struct device *dev)
> > > +{
> > > +     struct ucsi_ite *ite = dev_get_drvdata(dev);
> > > +
> > > +     enable_irq(ite->client->irq);
> > > +     return ucsi_resume(ite->ucsi);
> > > +}
> > > +
> > > +static DEFINE_SIMPLE_DEV_PM_OPS(ucsi_ite_pm, ucsi_ite_suspend,
> > > +                             ucsi_ite_resume);
> >
> > Is the enable/disable_irq really necessary - couldn't you just use
> > NOIRQ version of the PM operations (DEFINE_NOIRQ_DEV_PM_OPS)?
> >
> > Thanks,
> >
> > --
> > heikki

-- 
heikki
