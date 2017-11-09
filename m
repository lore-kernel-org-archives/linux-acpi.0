From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: RE: [PATCH v10 6/9] LPC: Support the LPC host on Hip06/Hip07 with
 DT bindings
Date: Thu, 9 Nov 2017 10:05:14 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CC7ED0@FRAEML521-MBX.china.huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-7-git-send-email-gabriele.paoloni@huawei.com>
 <20171109004604.vkrpyrxbogx7r4td@xps13.dannf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109004604.vkrpyrxbogx7r4td@xps13.dannf>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: dann frazier <dann.frazier@canonical.com>
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "rafael@kernel.org" <rafael@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "brian.starkey@arm.com" <brian.starkey@arm.com>, "olof@lixom.net" <olof@lixom.net>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>Linuxarm <li>
List-Id: linux-acpi@vger.kernel.org


Hi Dann

[...]

> > +
> > +#define START_WORK		0x01
> 
> Any reason not to put this in the LPC_ namespace as well?

No, not really. We'll make it consistent in the next patchset 

> 
> > +/* The minimal nanosecond interval for each query on LPC cycle
> status. */

[...]

> > + * hisilpc_target_in - trigger a series of lpc cycles to read
> required data
> > + *		       from target peripheral.
> > + * @pdev: pointer to hisi lpc device
> 
> It's now lpcdev
> 

Thanks, we'll change it.

> > + * @para: some parameters used to control the lpc I/O operations

[...]

> > + * @pio: the target I/O port address.
> 
> @outval & @pio are in the opposite order of the actual function

Thanks, we'll change it.

> 

[...]

> > +		lpcdev->io_host->devpara = NULL;
> > +		dev_err(dev, "OF: scan hisilpc children got failed(%d)\n",
> > +			ret);
> 
> nit: Maybe "OF: scanning hisilpc children failed(%d)" ?
> 

Yes, thanks we'll change it.

> > +		return ret;
> > +	}
> > +
> > +	dev_info(dev, "hslpc end probing. range[%pa - sz:%pa]\n",
> > +		&lpcdev->io_host->io_start,
> > +		&lpcdev->io_host->size);
> > +
> > +	return ret;
> > +}
> 
> 
>  -dann
