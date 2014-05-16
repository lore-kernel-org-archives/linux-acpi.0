From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] ACPI / platform: add IDs for Broadcom Bluetooth and GPS
 chips
Date: Fri, 16 May 2014 14:51:56 +0300
Message-ID: <20140516115155.GA10355@xps8300>
References: <1399550344-26952-1-git-send-email-heikki.krogerus@linux.intel.com>
 <17288023.xXIEp15spG@devpool02>
 <20140514115611.GB12238@xps8300>
 <1965215.zv0fvIVbHP@devpool02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13007 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbaEPLv7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 May 2014 07:51:59 -0400
Content-Disposition: inline
In-Reply-To: <1965215.zv0fvIVbHP@devpool02>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rolf Eike Beer <eb@emlix.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

Hi,

On Thu, May 15, 2014 at 09:50:45AM +0200, Rolf Eike Beer wrote:
> Heikki Krogerus wrote:
> > > the AzureWave AW-AH691A module looks similar to me, it is identified as
> > > AAM4752. However if I add it to that list I don't get anything, even with
> > > the brcmfmac driver loaded. Is there any magic missing?
> > 
> > Which machine are you using? Could you attach the output of acpidump?
> 
> this is an Aava Inari 8 tablet (pre-release hardware). To avoid spamming the 
> list with the same DSDT twice, please have a look at my reply in the thread 
> "Re: [Patch V2 0/9] I2C ACPI operation region handler support".

Okay. So the AAM4752 is a GPS module attached to the UART. You need
to add the HID to the list in drivers/acpi/acpi_platform.c and also to
the driver, which is net/rfkill/rfkill-gpio.c in this case.

But that will only give you a rfkill switch that allows you to
control the enable signal of the chip via rfkill framework. The actual
communication with the chip happens from userspace via /dev/ttySx
(/dev/ttyS2 on your board), just like with any other peripheral
attached to UARTs. So no drivers needed for that.


Br,

-- 
heikki
