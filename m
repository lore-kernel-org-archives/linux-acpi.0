From: Leif Liddy <leif.linux@gmail.com>
Subject: ACPI SPI slave device
Date: Tue, 23 Feb 2016 02:54:45 +0100
Message-ID: <CAAbRKOuTsBe0SBvcD-q+bBOSdkv_OWBu0-YWeMfKnM1o4MhT4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33185 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbcBWByp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Feb 2016 20:54:45 -0500
Received: by mail-ig0-f171.google.com with SMTP id y8so101185931igp.0
        for <linux-acpi@vger.kernel.org>; Mon, 22 Feb 2016 17:54:45 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm new to kernel development, and there's few fairly large gaps in my
understanding about
how drivers are meant to work, but hopefully you guys can point me in
the right direction.

The macbook8,1 (early 2015) has a keyboard/trackpad that is seen by
ACPI as a single SPI slave device.
It appears the only method to access the keyboard/trackpad is via
the SPI bus --my goal is the get keyboard/trackpad working.

I've recently submitted a kernel patch that binds the spi-pxa2xx-pci
driver to the Wildcat Point-LP Serial IO GSPI Controller. With this
patch, the SPI controller appears to be working...
http://www.spinics.net/lists/linux-spi/msg06867.html

----------LSHW INFO------------
*-serial:1
             description: Serial bus controller
             product: Wildcat Point-LP Serial IO GSPI Controller #1
             vendor: Intel Corporation
             physical id: 15.4
             bus info: pci@0000:00:15.4
             version: 03
             width: 32 bits
             clock: 33MHz
             capabilities: pm cap_list
             configuration: driver=3Dpxa2xx_spi_pci latency=3D0
             resources: irq:21 memory:c181a000-c181afff


What I'm having trouble with is sorting out how to register the SPI
slave device with the SPI controller.
**no slave devices are found when I modprobe the driver.
I'm not sure if this is something that should be done by the spi
driver (by calling an acpi function), or whether I must manually do
it.

=E2=80=93------------UDEV INFO---------------

P: /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT33C1:00/APP000D:00
E: DEVPATH=3D/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT33C1:00/APP=
000D:00
E: ID_VENDOR_FROM_DATABASE=3DApple Computer Inc
E: MODALIAS=3Dacpi:APP000D:APPLE-SPI-TOPCASE:
E: SUBSYSTEM=3Dacpi
E: USEC_INITIALIZED=3D13574842

**INT33C1 is the SPI master controller
**APP000D is the slave device

----------------SPI modules loaded-----------

spi_pxa2xx_platform    24576  0
spi_pxa2xx_pci         16384  0


The ACPI DSDT table (decoded):
https://bugzilla.kernel.org/attachment.cgi?id=3D202141


The full bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=3D108331


ANY help would be appreciated

Leif Liddy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
