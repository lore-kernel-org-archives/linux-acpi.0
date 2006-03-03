From: Michael Schierl <schierlm@gmx.de>
Subject: Re: Resume problems on Fujitsu-Siemens AMILO M7440G
Date: Fri, 03 Mar 2006 11:33:44 +0100
Message-ID: <44081B88.5090903@gmx.de>
References: <44076762.404@gmx.de> <1141349791.19013.1.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:13287 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751256AbWCCKdg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2006 05:33:36 -0500
In-Reply-To: <1141349791.19013.1.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi Shaohua,

Shaohua Li schrieb:
> On Fri, 2006-03-03 at 05:45 +0800, Michael Schierl wrote:

> If the video is dark, please try the boot options listed in
> documentation/power/video.txt.

I tried them (all three variations of acpi_sleep=), no change.

Since I do not have a Radeon graphics "card" (it's an Intel 91x), I did
not try those radeon specific tweaks.

> Did the keyboard response after resume?

The Num and Caps Lock LEDs do work (the notebook does not have a Scroll
Lock LED). Typing "reboot" has no effect, though.

I tried the same setup without SATA support, but from an initial ramdisk
instead. Same results, so it is most probably not the SATA driver.

Michael
