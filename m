From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 1/6] Documentation: add dts binding for X-Gene reboot dts node.
Date: Mon, 13 Jan 2014 20:43:51 +0100
Message-ID: <201401132043.52491.arnd@arndb.de>
References: <1389135041-16062-1-git-send-email-fkan@apm.com> <201401131619.35030.arnd@arndb.de> <CAL85gmCTsxng3jCaAcCjePE6Pxu7Jg98TDUqQrDFzsfW2GQwEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57649 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbaAMTn6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jan 2014 14:43:58 -0500
In-Reply-To: <CAL85gmCTsxng3jCaAcCjePE6Pxu7Jg98TDUqQrDFzsfW2GQwEg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Kan <fkan@apm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Monday 13 January 2014, Feng Kan wrote:
> FKAN: I could remove this dts node and create another dts node that
> describe the range of registers on the SCU and use that node in this driver.
> I am not sure which subsystem I can use to handle this case, I do see a reset
> subsystem in the kernel but more used for ip resets. Please kindly let
> me know. Thanks for the great feedback.

Is this related to the standard ARM SCU that manages multiprocessor
systems, or a different unit that uses the same name?

Since this is a global register range with a variety of things in it,
the best candidate IMHO would be to use the "syscon" driver. You can
mark the device node as 'compatible="apm,xgene-scu","syscon"' to let
it get picked up by the drivers/mfd/syscon driver, which creates
a "regmap" structure for it.

The reset driver then uses a DT reference with a phandle to the
SCU node and calls syscon_regmap_lookup_by_phandle() to get the
regmap. It can get the register number inside the regmap from DT
as well and use the regmap API to perform the reset.

	Arnd
