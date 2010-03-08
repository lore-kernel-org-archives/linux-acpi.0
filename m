From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Problem with uart and acpi
Date: Mon, 8 Mar 2010 11:21:06 -0700
Message-ID: <201003081121.07109.bjorn.helgaas@hp.com>
References: <20100225091328.GB22799@ugs.tarent.de> <201003031330.52498.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:12165 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627Ab0CHSVJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Mar 2010 13:21:09 -0500
In-Reply-To: <201003031330.52498.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henning Heinold <h.heinold@tarent.de>
Cc: linux-acpi@vger.kernel.org

On Wednesday 03 March 2010 01:30:52 pm Bjorn Helgaas wrote:
> On Thursday 25 February 2010 02:13:29 am Henning Heinold wrote:
> > we got some viliv x70 ez, atom based netbooks with wifi, bt, gsm, gps and touchscreen.
> > 
> > I got all running now under ubuntu with latest stable kernel 2.6.32.8 except the gps. Viliv claims
> > it is a sirf3 chip. It is connect to on irq 3(verified it under windows, where of course the
> > gps works), the 8250 modul run fine
> > and show me the that the uart is connected to ttyS1. Unfornatly when the 8250_pnp
> > is loaded the following occurs:
> > 
> > [    3.368311] serial 00:0c: activatedq
> > [    3.376287] serial 00:0c: disabled
> 
> Could you set CONFIG_PNP_DEBUG_MESSAGES=y, boot with "pnp.debug", and
> attach the complete dmesg log, please?

Ping, did you make any progress on this?  I'd like to help
resolve it if it's still a problem.

Bjorn
