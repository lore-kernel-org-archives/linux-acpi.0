From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Problem with uart and acpi
Date: Wed, 3 Mar 2010 13:30:52 -0700
Message-ID: <201003031330.52498.bjorn.helgaas@hp.com>
References: <20100225091328.GB22799@ugs.tarent.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:1628 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580Ab0CCUaz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2010 15:30:55 -0500
In-Reply-To: <20100225091328.GB22799@ugs.tarent.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henning Heinold <h.heinold@tarent.de>
Cc: linux-acpi@vger.kernel.org

On Thursday 25 February 2010 02:13:29 am Henning Heinold wrote:
> we got some viliv x70 ez, atom based netbooks with wifi, bt, gsm, gps and touchscreen.
> 
> I got all running now under ubuntu with latest stable kernel 2.6.32.8 except the gps. Viliv claims
> it is a sirf3 chip. It is connect to on irq 3(verified it under windows, where of course the
> gps works), the 8250 modul run fine
> and show me the that the uart is connected to ttyS1. Unfornatly when the 8250_pnp
> is loaded the following occurs:
> 
> [    3.368311] serial 00:0c: activatedq
> [    3.376287] serial 00:0c: disabled

Could you set CONFIG_PNP_DEBUG_MESSAGES=y, boot with "pnp.debug", and
attach the complete dmesg log, please?

Thanks,
  Bjorn
