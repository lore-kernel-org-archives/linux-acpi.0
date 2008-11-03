From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 0/7] sony-laptop for acpi-test
Date: Mon, 3 Nov 2008 21:48:43 +0900
Message-ID: <20081103124842.GA6865@inferi.kami.home>
References: <1225705280-12775-1-git-send-email-malattia@linux.it> <20081103111721.GA31688@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:60306
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754727AbYKCMsq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 07:48:46 -0500
Content-Disposition: inline
In-Reply-To: <20081103111721.GA31688@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org

On Mon, Nov 03, 2008 at 12:17:21PM +0100, Norbert Preining wrote:
> Hi Mattia,

Hi, thanks for testing.

> On Mo, 03 Nov 2008, Mattia Dongili wrote:
> > here is a first submission with some of the backlog I accumulated in
> > these months.
> 
> I tried your patches on top of 2.6.28-rc3 and the tests showed:
> - backlight is working via sys interface and xbacklight
> - hardkeys are still not working

what do you mean? some Fn backlight button (F5/F6 usually) or a separate
button?
Can you see if the kernel driver reports the events (pressing releasing
keys) but loading it with debug=1 ?
If it does it's just a matter for you to configure acpid or hal to
behave as you expect.

> - wifipower, wwanpower, bluetoothpower sys files do not work

can you send the kernel output after loading sony-laptop with debug=1
and echoing some value to those files?

thanks
-- 
mattia
:wq!
