From: Julian Wollrath <jwollrath@web.de>
Subject: Re: [Regression]: Changing brightness does not work with v3.16-rc4
Date: Mon, 14 Jul 2014 14:42:27 +0200
Message-ID: <20140714144227.1f270b6c@saldaea>
References: <20140712180636.698e2e4c@saldaea>
	<53C33B1D.4070500@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:54812 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564AbaGNMmb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2014 08:42:31 -0400
In-Reply-To: <53C33B1D.4070500@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi,

Am Mon, 14 Jul 2014 10:06:21 +0800
schrieb Aaron Lu <aaron.lu@intel.com>:
> > changing the brightness on my Thinkpad X230 with Intel HD4000
> > graphics, stopped working after commit 886129a8eebe (ACPI / video:
> > change acpi-video brightness_switch_enabled default to 0). Changing
> > it back to 1, fixes the problem, if "acpi_osi=!Windows 2012" is
> > also set. Before that commit just setting "acpi_osi=!Windows 2012"
> > was enough to get changing the brightness working.
> 
> Does your system have /sys/class/backlight/intel_backlight? Does it
> work if you manually change the brightness file like this:
> # cd /sys/class/backlight/intel_backlight
> # cat max_brightness
> xxxxx
> # echo xxx > brightness
> # echo xxx > brightness
> ...
yes, my system has /sys/class/backlight/intel_backlight and changing
the brightness works with writing to the "brightness"-file.

Cheers,
Julian
