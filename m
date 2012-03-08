From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Eject button handling in quickstart driver
Date: Thu, 8 Mar 2012 13:56:09 +0000
Message-ID: <20120308135609.GA841@srcf.ucam.org>
References: <4F576A87.1080401@ts.fujitsu.com>
 <20120307152110.GA10945@srcf.ucam.org>
 <4F58B128.1080505@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60439 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab2CHN4M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Mar 2012 08:56:12 -0500
Content-Disposition: inline
In-Reply-To: <4F58B128.1080505@ts.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Mar 08, 2012 at 02:16:24PM +0100, Rainer Koenig wrote:
> I had a look at the driver this morning. Just for testing purposes I
> changed it in a way that it sends KEY_EJECTCD codes over the
> input_report_key()-function, but this just works when I also have
> set the KEY_EJECTCD bit with set_bit() before.

Yup.

> This brings me to the point, how I need to set the bits in that array
> when the driver is loaded? Setting it with the "0x01" that the GHID
> method returns is of no use, on the other hand I can replace the keymap
> with /lib/udev/keymap, but that probably doesn't affect the bits in this
> array.

It'll affect the bits in those arrays if you have the appropriate keymap 
get and set functions in the driver. The mapping of GHID values to 
keycodes is vendor (and plausibly machine...) specific per spec, and the 
way we typically handle that is with keymaps.

> The easiest (and maybe possible because BIOS development is just around
> the corner here) would be to change the ACPI code so that GHID
> returns the KEY_EJECTCD already, then it works out of the box, but
> the open
> question is if this change will lead do regressions in the already
> existing Windows driver.

Right, you'd need to update the registry entries in Windows.

> Another idea: Making the quickstart driver aware of common HIDs like
> the ODDE in my case and creating a correct keymap during driver
> initalization. Then there is no need to remap GHID results to
> keycodes
> via /lib/udev/keymap. What do you think of this idea?

ODDE isn't a HID, it's just a device name. There's no vendor 
namespacing, and on some hardware it'll change between BIOS versions.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
