From: Julian Wollrath <jwollrath@web.de>
Subject: Re: New ACPI warnings with v3.16.0-rc1
Date: Thu, 26 Jun 2014 11:05:34 +0200
Message-ID: <20140626110534.7e17ca24@saldaea>
References: <20140618235004.25295650@saldaea>
	<8028563.JQMq23p6sJ@vostro.rjw.lan>
	<1403132844.30783.33.camel@rzhang1-toshiba>
	<20140619013830.265e74cd@saldaea>
	<20140619013921.5c05ded1@saldaea>
	<20140625165603.391df68f@saldaea>
	<1403739189.16305.72.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:54744 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828AbaFZJFl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jun 2014 05:05:41 -0400
In-Reply-To: <1403739189.16305.72.camel@rzhang1-toshiba>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

Am Thu, 26 Jun 2014 07:33:09 +0800
schrieb Zhang Rui <rui.zhang@intel.com>:

> On Wed, 2014-06-25 at 16:56 +0200, Julian Wollrath wrote:
> > Hmm, lets hope, this mail reaches the mailing list.
> > 
> yes, but I can not see your original post, thus I'm not clear what the
> problems/warnings are.
> please re-send your original email to the list.
The original post (and the threas beloning to it can be found under
http://marc.info/?i=20140618235004.25295650%20()%20saldaea or below.

Please note also, what if wrote in a follow up:
> I just look into the dmesg output again and saw the following:
> [   14.560580] lpc_ich: Resource conflict(s) found affecting gpio_ich
>
> Then I checked the git log and stumbled upon commit 62cf2cdb99c7e
> (mfd: lpc_ich: Enable GPIO for Panther Point). Since I have a Panther
> Point chipset, that commit is possibly to blame, since now that
> driver can also handle Panther Point. The only problem is, that
> CONFIG_LPC_ICH gets auto-enabled by having CONFIG_ITCO_WDT (Intel
> Watchdog support) enabled and it can not be disabled without
> disabling the watchdog support.

Cheers,
Julian

Original message:
Subject: New ACPI warnings with v3.16.0-rc1
Date: Wed, 18 Jun 2014 23:50:04 +0200

Hi,

with v3.16.0-rc1 I get the following warnings, which I did not occur
with v3.15.1:
[   14.558365] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042f conflicts with OpRegion 0x0000000000000400-0x000000000000047f (\_SB_.PCI0.LPC_.PMIO) (20140424/utaddress-258)
[   14.558377] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver 
[   14.558386] ACPI Warning: SystemIO range 0x0000000000000540-0x000000000000054f conflicts with OpRegion 0x0000000000000500-0x000000000000057f (\_SB_.PCI0.LPC_.LPIO) (20140424/utaddress-258)
[   14.558392] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver 
[   14.558395] ACPI Warning: SystemIO range 0x0000000000000530-0x000000000000053f conflicts with OpRegion 0x0000000000000500-0x000000000000057f (\_SB_.PCI0.LPC_.LPIO) (20140424/utaddress-258)
[   14.558401] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver 
[   14.558403] ACPI Warning: SystemIO range 0x0000000000000500-0x000000000000052f conflicts with OpRegion 0x0000000000000500-0x000000000000057f (\_SB_.PCI0.LPC_.LPIO) (20140424/utaddress-258)
[   14.558409] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver

How can one find out, what the native driver is, and if there is an
ACPI driver?


Thank you for your time, with best regards,
Julian Wollrath
