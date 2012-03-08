From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Subject: Re: [PATCH] Eject button handling in quickstart driver
Date: Thu, 08 Mar 2012 14:16:24 +0100
Message-ID: <4F58B128.1080505@ts.fujitsu.com>
References: <4F576A87.1080401@ts.fujitsu.com> <20120307152110.GA10945@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:53911 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080Ab2CHNQ2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Mar 2012 08:16:28 -0500
In-Reply-To: <20120307152110.GA10945@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Matthew,

Am 07.03.2012 16:21, schrieb Matthew Garrett:
> This is wrong. Since the GHID method returns an arbitrary
> vendor-specific value, you should just make sure that there's
> appropriate keymap remapping support and then provide a udev fragment
> that does the appropriate GHID->keycode assignment. Also, you really =
do
> need to report this as KEY_CDEJECT - it's not acceptable to require a=
n
> acpid script.

I had a look at the driver this morning. Just for testing purposes I
changed it in a way that it sends KEY_EJECTCD codes over the
input_report_key()-function, but this just works when I also have
set the KEY_EJECTCD bit with set_bit() before.

This brings me to the point, how I need to set the bits in that array
when the driver is loaded? Setting it with the "0x01" that the GHID
method returns is of no use, on the other hand I can replace the keymap
with /lib/udev/keymap, but that probably doesn't affect the bits in thi=
s
array.

The easiest (and maybe possible because BIOS development is just around
the corner here) would be to change the ACPI code so that GHID returns=20
the KEY_EJECTCD already, then it works out of the box, but the open
question is if this change will lead do regressions in the already=20
existing Windows driver.

Another idea: Making the quickstart driver aware of common HIDs like th=
e=20
ODDE in my case and creating a correct keymap during driver=20
initalization. Then there is no need to remap GHID results to keycodes
via /lib/udev/keymap. What do you think of this idea?

Regards
Rainer
--=20
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux Business Clients
Dept. TSP WPS R&D SW OSE

=46ujitsu Technology Solutions
B=FCrgermeister-Ullrich-Str. 100
86199 Augsburg
Germany

Telephone: +49-821-804-3321
Telefax:   +49-821-804-2131
Mail:      mailto:Rainer.Koenig@ts.fujitsu.com

Internet         ts.fujitsu.com
Company Details  ts.fujitsu.com/imprint.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
