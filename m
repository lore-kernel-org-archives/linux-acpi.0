Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F205630594F
	for <linux-acpi@vger.kernel.org>; Tue,  1 Sep 2026 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264247; cv=pass; b=I/0taXaY5JQ6uKRKCJed8hgftVWBc9zhmHyNQQEpoy4Tve+bUGmtVpy+PKJAgEm+Z03NmUoaEF2m/pX/y51axkEihEAKm3yTz6QtkFM3AIQmOUOYRgwJETpMk71hYAz70hTruQyoiijikeZGWmD1fa3abOozXUSoXItkBW+6dVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264247; c=relaxed/simple;
	bh=4wX95984+0yQBtDcOClZ0inBv6+RRrIe9kyWoLrt8CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xb+hPiVgSIgwf1SVTXeOQ5TVieXrgwQDjxXBJWRkFe4csQ+EE4kDuT8KYHbH5Np68jNT9oNqNRl5o121npU0GVGnmIqWS87uObwtgfMIljgPz1g1uykX3ztPTjCze5MTJrp7PqgR8Tj2bYwaW/SlPzdJ/3qyltQQM62hy3a/DDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tl/KTB3j; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl/KTB3j"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b5ef26b92dso4619736e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 01 Sep 2026 05:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788264243; cv=none;
        d=google.com; s=arc-20260327;
        b=nKLaolbsKg49nXnDn9pRbWTiJprk3rwRv9TlP6vNbaQ2PbvJ1fe0uLECuRqFl9sHK9
         zgGOovUoONmOcf5a8h+ExCMoSvh9xcJx7eMOm/7+PGMZ9g5oW60i6z07LXjFaGYPOfvk
         esSovwlu0wUb/foGcrFC6a2wKITrXiMmhbpY37KkZ+POM+O0kmAVjW5uBkr/dNuVi6rs
         9GjrWfGXyWN6gYZZwkZUPBwLCu7QXZwqkTeNfV6E0mYym8EUsbecnKDw1Pm9V/q4Txw7
         ygp0QmM2b7FhUo6o9RITfKxRhEIP93A4muJF26TX3Zc2hDCvktQrr1uVI1uzPqwTxyb1
         /SaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sofiRxnEQnW9qdiNAvl3XkRdrOIskc1MiCk8v3PsR+I=;
        fh=PXiRQ5psMvyueN2+6+VgjS/9oka4atp7i1LjY4q27hg=;
        b=shLBS1U9lTo457PM12F4J1uyIroWJ687XWthQBgLo+QN2LqwlERow5P8DnD7CxFvPE
         NV39F6e/wb+5RA++lLOwDCm50McHfvyBNxmlZ7dXxpVcxPOjiYTQ77nr7QtY7l0M929T
         MHkmMajw9p2srrkiRQwMSpB1a3mVt62p6zh//QAfvxeWzxQBitxIkd53earD2cQi1V9G
         AkF0mVu6DZMpPUaJ/bXcjjFhOEvzKJ8qVxtQlcxZoKO7ZEQyvfTS94bh72nJ+CzVNV6p
         Vy+lg99cVUquLXMLjkcqPpnlKoFvhD1VxeaEzAvpPzRRiqdQJY/obmB+6GXcNx234sSL
         xc3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788264243; x=1788869043; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sofiRxnEQnW9qdiNAvl3XkRdrOIskc1MiCk8v3PsR+I=;
        b=Tl/KTB3jFB9IpDWcykmCUnueumvOV/8OcVp7B3u7JsWN7nuvrvu6Z9tVHDiJqDGzzv
         9S6fplWm3qAC4g2S2GV6nYH0juts6PyZW3BhAyVEzZlapHa7uEqqECfbqBFEqNxNpHbU
         CcxhDmGwzakUkp0ES7o455Gho8FgvcvIHBmNzwg1988XbjY1iGa5sL4sRIOOVB12rbFg
         aAQtq84vMa1f5rLlm4y/2+D71sy3QX+yoZ2XYldk60+K0mHNIBAzDJH81Wc02zoaWu7U
         R0qoXTDVw9bSg+H/8ZEFCSryoTpYqjY/2HzWUKewS/Eu6potxFOcjTtPLMhfUjwhiqrm
         1+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264243; x=1788869043;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sofiRxnEQnW9qdiNAvl3XkRdrOIskc1MiCk8v3PsR+I=;
        b=lt5LXoBEH8KCf+UccWGPL5oF0Cl6GNF/VMp35HKCLs8mjWZI2AjlxpRvNwG4N0mZdZ
         A1dwklgdlM+/7J1r2+gvCdTegAwdNPyTx9diQbZFdPCmCgaLPYgko+N8GGY6FatHA54E
         ZbdM3Kzug8EPsaOXj79xWqwq/EoxppnETrzGLEsbHIK8vOZc6BLDnN5G9jGG7jOIykJq
         9TIQ/TCMREvA/G0nDAPfQVix4i5aGX0TuUPqrsJUBKro/HcGntiyI9g+iOGXBQPLRWiI
         SnCHtO/bpBrpEL1EK8SI0IC8IHoFxt0NFRV2PS7Rg/JnCdzyS+lNm6IZn7mgOkyRBNIj
         ew4g==
X-Gm-Message-State: AFuF++kiwXKefs5FrNdnRI3mqIT+dTd6BflsCL48bDKS9wGsC4hJJScJ
	2CV70uokKNZ+lbUWMOsBEcN3TS3NASnbbe3GPUaXaCcT70CCL6ThaAq6yLxP2Z2WOMZliQ2s3z5
	0MU8f14HUFdfltzj2q8KDuvdRJ5dtGERaYD23swtNng==
X-Gm-Gg: AYBFou3hdVj0PzzewekU9p0tzsIQdvPpC/VBshuKq/na6bFyHf/jb3Q8pY7igPQk/x6
	uNhXmTSEyLIMrFMwG1sPzGkWuQ6amv6nFooZAIGvV8/2enCGUL/Gkkd3CcbdEX3+jExMtzzoJrU
	yPu3QWiZ5yoenOfZjANyA+Cwl1R5dlkVJH+Iv5i9az/OigL0+o/1NZYEIO6VO/RLXwt4Ch3Cc0/
	Q8GwiIxc0fVkf3Lr6sobWJzCDmncM1/zNzgma3xqDJj6za5lp/XTsLln1Z9Abi5qWGhqbIOmiGB
	hHY0kJIxR6esuOEbBTd5cWLslMD+8wro3pAif2R46L3LKr6y8NGdDp/aIiap7Se7Eri6A1jCavD
	waOqy2kO7t3gPumQqzb6Sc4VNXZ/jr3rD4KSyIyBZv4pl7x9rfWv800layKH3
X-Received: by 2002:a2e:a7ca:0:b0:3a3:1418:ac70 with SMTP id
 38308e7fff4ca-3a33964aa2dmr14956651fa.10.1788264242504; Tue, 01 Sep 2026
 05:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829145516.13500-1-edward.blair@gmail.com>
 <20260829145516.13500-3-edward.blair@gmail.com> <apavoDwVFw_FKRNd@black.igk.intel.com>
In-Reply-To: <apavoDwVFw_FKRNd@black.igk.intel.com>
From: Edward Blair <edward.blair@gmail.com>
Date: Tue, 1 Sep 2026 13:03:50 +0100
X-Gm-Features: AcwNN1UEea8S3wAXLqqHMJokgR8_-cuL_GQ1DBl7z6gMRKRRgcsCI9a3_hBWT7M
Message-ID: <CAJDQNgjq-oxQkdYK+fTSd5AHMjM-qTcSPo+s2-+W=Pcn7jYr-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: typec: ucsi: add ITE885x I2C transport driver
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, rafael@kernel.org, 
	lenb@kernel.org, mika.westerberg@linux.intel.com, gregkh@linuxfoundation.org, 
	W_Armin@gmx.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks,

I will add the explicit includes and use guard(mutex) for event_lock.

I kept the explicit IRQ handling because ucsi_resume() queues work which
issues UCSI commands. If the callbacks are moved to the noirq phase,
that work can run before the parent I2C controller's resume_early or
resume callback, while the controller may still be unavailable.

The current ordering disables the device IRQ before quiescing UCSI, then
re-enables it during normal resumption after the I2C bus has resumed. Does
that address your concern, or would it be preferable the IRQ and UCSI
handling to be split across separate PM phases?

Thanks,
Edward

On Tue, 1 Sept 2026 at 11:57, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Sat, Aug 29, 2026 at 03:55:16PM +0100, Edward Blair wrote:
> > Add a UCSI transport driver for ITE8853 and ITE8800 through ITE8805
> > USB Type-C controllers found on desktop motherboards.
> >
> > These controllers expose CCI, MESSAGE_IN and CONTROL at ITE-specific I2C
> > offsets and signal UCSI and vendor events through a shared interrupt
> > status register. Read and cache each complete UCSI event before
> > acknowledging it so command data remains coherent between the interrupt
> > handler and UCSI core.
> >
> > The interface does not expose a VERSION register and does not accept
> > PPM_RESET over I2C. Report UCSI 1.0, limit MESSAGE_IN to its 16-byte
> > window and handle PPM_RESET locally, matching the vendor driver's
> > behavior.
> >
> > Signed-off-by: Edward Blair <edward.blair@gmail.com>
> > ---
> >  drivers/usb/typec/ucsi/Kconfig    |  11 +
> >  drivers/usb/typec/ucsi/Makefile   |   1 +
> >  drivers/usb/typec/ucsi/ucsi_ite.c | 395 ++++++++++++++++++++++++++++++
> >  3 files changed, 407 insertions(+)
> >  create mode 100644 drivers/usb/typec/ucsi/ucsi_ite.c
> >
> > diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> > index 87dd992a4..3819c4f73 100644
> > --- a/drivers/usb/typec/ucsi/Kconfig
> > +++ b/drivers/usb/typec/ucsi/Kconfig
> > @@ -104,4 +104,15 @@ config UCSI_HUAWEI_GAOKUN
> >         To compile the driver as a module, choose M here: the module will be
> >         called ucsi_huawei_gaokun.
> >
> > +config UCSI_ITE
> > +     tristate "UCSI Interface Driver for ITE885x"
> > +     depends on ACPI && I2C
> > +     help
> > +       This driver enables UCSI support on platforms that expose an ITE8853
> > +       or ITE8800-ITE8805 USB Type-C controller over I2C, commonly found
> > +       on ASUS Z690/Z790/X670E motherboards.
> > +
> > +       To compile the driver as a module, choose M here: the module will be
> > +       called ucsi_ite.
> > +
> >  endif
> > diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> > index c7e38bf01..9bc1d6bbb 100644
> > --- a/drivers/usb/typec/ucsi/Makefile
> > +++ b/drivers/usb/typec/ucsi/Makefile
> > @@ -28,3 +28,4 @@ obj-$(CONFIG_UCSI_PMIC_GLINK)               += ucsi_glink.o
> >  obj-$(CONFIG_CROS_EC_UCSI)           += cros_ec_ucsi.o
> >  obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)  += ucsi_yoga_c630.o
> >  obj-$(CONFIG_UCSI_HUAWEI_GAOKUN)     += ucsi_huawei_gaokun.o
> > +obj-$(CONFIG_UCSI_ITE)                       += ucsi_ite.o
> > diff --git a/drivers/usb/typec/ucsi/ucsi_ite.c b/drivers/usb/typec/ucsi/ucsi_ite.c
> > new file mode 100644
> > index 000000000..16b22c77f
> > --- /dev/null
> > +++ b/drivers/usb/typec/ucsi/ucsi_ite.c
> > @@ -0,0 +1,395 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * UCSI I2C transport driver for ITE885x USB-C controllers
> > + *
> > + * ITE8853/ITE8800-ITE8805 are UCSI-compliant USB-C controllers found on
> > + * desktop motherboards. They communicate over I2C using UCSI registers at
> > + * ITE-specific offsets and signal events through a vendor interrupt register.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
>
> We need to include everything instead of relying on nested headers
> nowadays.
>
>         linux/device.h
>         linux/device/devres.h
>         linux/dev_printk.h
>         linux/pm.h
>         linux/string.h
>
> > +static int ucsi_ite_process_event(struct ucsi_ite *ite, u32 *cci)
> > +{
> > +     u8 message_in[ITE_MESSAGE_IN_MAX_LEN] = {};
> > +     __le32 raw_cci;
> > +     u8 status;
> > +     u8 len = 0;
> > +     int event;
> > +     int err = 0;
> > +     int ret;
> > +
> > +     mutex_lock(&ite->event_lock);
>
> guard(mutex)(@ite->event_lock);
>
> > +     ret = ucsi_ite_read(ite, ITE_REG_INT_STATUS, &status, sizeof(status));
> > +     if (ret)
> > +             goto out_unlock;
> > +
> > +     status &= ITE_INT_MASK;
> > +     if (!status) {
> > +             mutex_lock(&ite->received_lock);
> > +             *cci = ite->cci;
> > +             mutex_unlock(&ite->received_lock);
> > +             ret = ITE_EVENT_NONE;
> > +             goto out_unlock;
> > +     }
> > +
> > +     if (status & ITE_INT_CCI) {
> > +             err = ucsi_ite_read(ite, ITE_REG_CCI, &raw_cci,
> > +                                 sizeof(raw_cci));
> > +             if (!err) {
> > +                     *cci = le32_to_cpu(raw_cci);
> > +                     len = UCSI_CCI_LENGTH(*cci);
> > +
> > +                     if (len > sizeof(message_in)) {
> > +                             len = sizeof(message_in);
> > +                             *cci &= ~GENMASK(15, 8);
> > +                             *cci |= UCSI_SET_CCI_LENGTH(len);
> > +                     }
> > +                     if (len) {
> > +                             err = ucsi_ite_read(ite, ITE_REG_MESSAGE_IN,
> > +                                                 message_in, len);
> > +                     }
> > +             }
> > +     }
> > +
> > +     /* Acknowledge each latched event with the value expected by the PPM. */
> > +     if (status & ITE_INT_VENDOR_ALERT) {
> > +             u8 ack = ITE_INT_VENDOR_ALERT;
> > +
> > +             ret = ucsi_ite_write(ite, ITE_REG_INT_ACK, &ack, sizeof(ack));
> > +             if (ret)
> > +                     goto out_unlock;
> > +     }
> > +
> > +     if ((status & ITE_INT_CCI) && !err) {
> > +             u8 ack = ITE_INT_CCI;
> > +
> > +             ret = ucsi_ite_write(ite, ITE_REG_INT_ACK, &ack, sizeof(ack));
> > +             if (ret)
> > +                     goto out_unlock;
> > +     }
> > +
> > +     if (err) {
> > +             ret = err;
> > +             goto out_unlock;
> > +     }
> > +
> > +     if (status & ITE_INT_CCI) {
> > +             mutex_lock(&ite->received_lock);
> > +             ite->cci = *cci;
> > +             memset(ite->message_in, 0, sizeof(ite->message_in));
> > +             memcpy(ite->message_in, message_in, len);
> > +             mutex_unlock(&ite->received_lock);
> > +             event = ITE_EVENT_CCI;
> > +     } else {
> > +             mutex_lock(&ite->received_lock);
> > +             *cci = ite->cci;
> > +             mutex_unlock(&ite->received_lock);
> > +             event = ITE_EVENT_VENDOR;
> > +     }
> > +
> > +     ret = event;
> > +
> > +out_unlock:
> > +     mutex_unlock(&ite->event_lock);
> > +     return ret;
> > +}
>
> > +static int ucsi_ite_suspend(struct device *dev)
> > +{
> > +     struct ucsi_ite *ite = dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     disable_irq(ite->client->irq);
> > +     ret = ucsi_suspend(ite->ucsi);
> > +     if (ret)
> > +             enable_irq(ite->client->irq);
> > +
> > +     return ret;
> > +}
> > +
> > +static int ucsi_ite_resume(struct device *dev)
> > +{
> > +     struct ucsi_ite *ite = dev_get_drvdata(dev);
> > +
> > +     enable_irq(ite->client->irq);
> > +     return ucsi_resume(ite->ucsi);
> > +}
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(ucsi_ite_pm, ucsi_ite_suspend,
> > +                             ucsi_ite_resume);
>
> Is the enable/disable_irq really necessary - couldn't you just use
> NOIRQ version of the PM operations (DEFINE_NOIRQ_DEV_PM_OPS)?
>
> Thanks,
>
> --
> heikki
