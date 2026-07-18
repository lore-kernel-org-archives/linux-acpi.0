Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C264369D4E;
	Sat, 18 Jul 2026 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365613; cv=none; b=GaxUhwc8NY/Y4irxm76NJtzzkq9tf2cOu63XYjbihy1ESV5yM81BxXhlq0fHuJ5BoQ3+h7ia+RNlctVevmCeYRWQFLj7HieGS7FTompsykNVSoXdNciVQDpnf9ENPmVJ0zgMaCHDMIkAwl24CIcr1nbMmL3KElY3w8kgBC1Q5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365613; c=relaxed/simple;
	bh=gNXDrin3DzBUk0zH9pSW0emqVDOEgRNQhlMqZWdJWXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0wbog06PktzNX9DaQCpNZDYwQ396JI5kbgfyglXvb65Lqu7eOnzZj0Dwbb0MPsNWlp6d47t4gwNGoxsOJRr9YzzEMZaIk45Kxx8yfy0PHSiqO+gPvi9olzFWAPfjikxjyaKtB0ERxmgh5lbhsK73AGGPKcCazFZmGZ6n9kuaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OPoNRPX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OPoNRPX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC051F00A3A;
	Sat, 18 Jul 2026 09:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784365611;
	bh=S2zI+wR3yyjuVNWQhxPVgWP56cBc4xW3C5VNn14+Le0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OPoNRPX87l9yo2XNtZXSXa/f9+Gef7amew3/hbCYW3eRQns+3fVmAOCe2PKwqWlSR
	 4VOEjO+lBH30p8LYBp+fOHM9iZuP95k8vhPTVqsD7MR0RPhazZwSvoFIUQB9ylv3WA
	 cpfr1WuMA30IBljs3J8NlUAyyZoPi4+spH37PT6A=
Date: Sat, 18 Jul 2026 11:05:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Metehan =?iso-8859-1?Q?G=FCnen?= <metehangnen@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 0/4] drivers/misc: add Goodix GXFP5130 eSPI fingerprint
 sensor driver
Message-ID: <2026071842-timing-distress-ad5a@gregkh>
References: <20260718081431.25456-1-metehangnen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260718081431.25456-1-metehangnen@gmail.com>

On Sat, Jul 18, 2026 at 11:14:27AM +0300, Metehan Günen wrote:
> This series adds a kernel driver for the Goodix GXFP5130 fingerprint
> sensor found in Huawei MateBook laptops (D16 2024, X Pro 2024, 14 2024).
> 
> The sensor is enumerated through ACPI (HID: GXFP5130) and communicates
> with the host via an eSPI-based memory-mapped mailbox window plus three
> GPIOs. It does not use SPI or I2C bus drivers.
> 
> A misc character device /dev/gxfp is exposed to userspace. The libfprint
> library (with a corresponding GXFP5130 plugin) uses this device to perform
> biometric enrollment and verification via fprintd.

Is that the "normal" user/kernel api for these types of sensors?  I
thought we had a real api these days, and a vendor one was not generally
a good idea as you are just exposing raw hardware design to userspace.

> The four patches are:
>   [1/4] UAPI header (include/uapi/linux/gxfp_ioctl.h)
>   [2/4] Driver source tree (drivers/misc/gxfp5130/)
>   [3/4] Documentation (Documentation/misc-devices/gxfp5130.rst)
>   [4/4] MAINTAINERS entry
> 
> Metehan Günen (4):
>   include/uapi/linux: add gxfp_ioctl.h for GXFP5130 fingerprint sensor
>   drivers/misc: add Goodix GXFP5130 eSPI fingerprint sensor driver
>   Documentation/misc-devices: add gxfp5130.rst
>   MAINTAINERS: add entry for GXFP5130 fingerprint sensor driver
> 
>  Documentation/misc-devices/gxfp5130.rst       |  90 +++++++
>  Documentation/misc-devices/index.rst          |   1 +
>  MAINTAINERS                                   |   7 +
>  drivers/misc/Kconfig                          |   2 +
>  drivers/misc/Makefile                         |   2 +
>  drivers/misc/gxfp5130/Kconfig                 |  18 ++
>  drivers/misc/gxfp5130/Makefile                |  28 ++
>  drivers/misc/gxfp5130/cmd/gxfp_cmd.c          | 177 ++++++++++++
>  drivers/misc/gxfp5130/cmd/gxfp_cmd.h          |  54 ++++
>  .../misc/gxfp5130/cmd/gxfp_cmd_mcu_config.c   |  28 ++
>  .../misc/gxfp5130/cmd/gxfp_cmd_mcu_config.h   |  12 +
>  .../misc/gxfp5130/cmd/gxfp_cmd_mcu_state.c    |  89 +++++++
>  .../misc/gxfp5130/cmd/gxfp_cmd_mcu_state.h    |  30 +++
>  drivers/misc/gxfp5130/cmd/gxfp_cmd_reset.c    | 185 +++++++++++++
>  drivers/misc/gxfp5130/cmd/gxfp_cmd_reset.h    |  27 ++
>  drivers/misc/gxfp5130/cmd/gxfp_cmd_version.c  | 100 +++++++
>  drivers/misc/gxfp5130/cmd/gxfp_cmd_version.h  |  22 ++
>  drivers/misc/gxfp5130/driver/gxfp_irq.c       |  57 ++++
>  drivers/misc/gxfp5130/driver/gxfp_irq.h       |   9 +
>  drivers/misc/gxfp5130/driver/gxfp_platform.c  | 251 ++++++++++++++++++
>  drivers/misc/gxfp5130/driver/gxfp_platform.h  |  12 +
>  drivers/misc/gxfp5130/driver/gxfp_trace.c     | 179 +++++++++++++
>  drivers/misc/gxfp5130/driver/gxfp_trace.h     |  15 ++
>  drivers/misc/gxfp5130/driver/gxfp_uapi.h      |  25 ++
>  drivers/misc/gxfp5130/driver/gxfp_uapi_ctrl.c | 136 ++++++++++
>  drivers/misc/gxfp5130/driver/gxfp_uapi_fifo.c | 245 +++++++++++++++++
>  drivers/misc/gxfp5130/driver/gxfp_uapi_misc.c | 123 +++++++++
>  drivers/misc/gxfp5130/gxfp_main.c             | 127 +++++++++
>  drivers/misc/gxfp5130/hw/gxfp_acpi.c          | 130 +++++++++
>  drivers/misc/gxfp5130/hw/gxfp_acpi.h          |  15 ++
>  drivers/misc/gxfp5130/hw/gxfp_delay.c         |  15 ++
>  drivers/misc/gxfp5130/hw/gxfp_delay.h         |   7 +
>  drivers/misc/gxfp5130/hw/gxfp_gpio.c          |  64 +++++
>  drivers/misc/gxfp5130/hw/gxfp_gpio.h          |  17 ++
>  drivers/misc/gxfp5130/hw/gxfp_mmio.c          |  45 ++++
>  drivers/misc/gxfp5130/hw/gxfp_mmio.h          |  10 +
>  .../misc/gxfp5130/include/gxfp_constants.h    |  38 +++
>  drivers/misc/gxfp5130/include/gxfp_priv.h     |  55 ++++
>  .../misc/gxfp5130/proto/gxfp_goodix_proto.c   |  84 ++++++
>  .../misc/gxfp5130/proto/gxfp_goodix_proto.h   |  31 +++
>  drivers/misc/gxfp5130/proto/gxfp_mp_proto.c   |  96 +++++++
>  drivers/misc/gxfp5130/proto/gxfp_mp_proto.h   |  27 ++
>  .../gxfp5130/transport/gxfp_espi_common.c     |  80 ++++++
>  .../gxfp5130/transport/gxfp_espi_common.h     |  27 ++
>  .../gxfp5130/transport/gxfp_espi_rx_irq.c     | 120 +++++++++
>  .../gxfp5130/transport/gxfp_espi_rx_irq.h     |  15 ++
>  .../gxfp5130/transport/gxfp_espi_rx_sync.c    |  96 +++++++
>  .../gxfp5130/transport/gxfp_espi_rx_sync.h    |  14 +
>  .../misc/gxfp5130/transport/gxfp_espi_tx.c    |  88 ++++++
>  .../misc/gxfp5130/transport/gxfp_espi_tx.h    |  20 ++
>  include/uapi/linux/gxfp_ioctl.h               |  43 +++
>  51 files changed, 3188 insertions(+)

Why isn't this just one single .c file?  3k for a driver is nothing,
this is a mess of stuff that odds are, can be much much smaller if its
all in one single file, and one .h file for the uapi.

What caused this to be split up so crazily?

And no copyright notices at all?  Are you sure about that?

thanks,

greg k-h
