From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Regression]: Changing brightness does not work with v3.16-rc4
Date: Mon, 14 Jul 2014 20:21:19 +0200
Message-ID: <100384914.3msa0DXJgJ@vostro.rjw.lan>
References: <20140712180636.698e2e4c@saldaea> <20140712182452.19ef6a91@saldaea>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64736 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751602AbaGNSDF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jul 2014 14:03:05 -0400
In-Reply-To: <20140712182452.19ef6a91@saldaea>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julian Wollrath <jwollrath@web.de>
Cc: linux-acpi@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>

On Saturday, July 12, 2014 06:24:52 PM Julian Wollrath wrote:
> Hi,
> 
> > changing the brightness on my Thinkpad X230 with Intel HD4000
> > graphics, stopped working after commit 886129a8eebe (ACPI / video:
> > change acpi-video brightness_switch_enabled default to 0). Changing
> > it back to 1, fixes the problem, if "acpi_osi=!Windows 2012" is also
> > set. Before that commit just setting "acpi_osi=!Windows 2012" was
> > enough to get changing the brightness working.
>
> small correction: It setting "acpi_osi=!Windows 2012" does only help
> when using a kernel with commit 886129a8eebe as HEAD, with v3.16-rc4
> setting video.brightness_switch_enabled=1 and acpi_osi=!Windows 2012 or
> just one of them, does not make changing the brightness work again.

And reverting commit 751109aad583 (ACPI / video: Change the default for
video.use_native_backlight to 1) make that last problem go away, right?

We are going to rever commit 886129a8eebe for other reasons, so can you
please revert it from 3.16-rc5 on your system and report back?

Rafael

