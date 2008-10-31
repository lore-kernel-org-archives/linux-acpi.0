From: "Peter Mahlknecht" <mali100@gmx.net>
Subject: Re: ACPI reads wrong temperature
Date: Fri, 31 Oct 2008 22:09:13 +0100
Message-ID: <20081031210913.3180@gmx.net>
References: <20081031140247.325670@gmx.net>
 <20081031143030.GA9177@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52182 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752035AbYJaVJQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Oct 2008 17:09:16 -0400
In-Reply-To: <20081031143030.GA9177@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org


-------- Original-Nachricht --------
> Datum: Fri, 31 Oct 2008 14:30:30 +0000
> Von: Matthew Garrett <mjg59@srcf.ucam.org>
> An: Peter Mahlknecht <mali100@gmx.net>
> CC: linux-acpi@vger.kernel.org
> Betreff: Re: ACPI reads wrong temperature

> On Fri, Oct 31, 2008 at 03:02:47PM +0100, Peter Mahlknecht wrote:
> > Hi, 
> > I installed Debian Lenny (2.6.26-1-686) on my notebook (Samsung P40 with
> the latest Bios 09HK), but the notebook continued to shutting down with
> the message "Critical temperature reached (65535 C). Shutting down.". 
> > To stop this I patched the thermal module, so that it ignores every
> temperature above 1000 C. 
> 
> Do you get wrong temperatures if you never load the max6657 driver?
Thanks for the hint. I get the wrong temperatures after loading the lm90 module (hwmon driver), but also if i load em28xx_cx25843, which is a part of the driver for my tv-card. Both modules depend on i2c-core, so probably the bug is related to the i2c bus?

B.R. Peter
-- 
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
