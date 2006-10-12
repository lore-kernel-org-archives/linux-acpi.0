From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP Compaq nc6320
Date: Thu, 12 Oct 2006 01:08:57 +0100
Message-ID: <1160611737.5429.4.camel@pcjc2lap>
References: <1160604516.5349.14.camel@pcjc2lap>
	 <1160605036.8599.1.camel@pcjc2lap>  <1160610784.7763.3.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:9928 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030486AbWJLAJG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 20:09:06 -0400
Received: from acce212d.ipt.aol.com ([172.206.33.45]:65135 helo=[192.168.1.70])
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:465)
	with esmtpsa (LOGIN:pcjc2) (SSLv3:RC4-MD5:128)
	id 1GXo8A-0007Vn-3c (Exim 4.63) for linux-acpi@vger.kernel.org
	(return-path <pcjc2@cam.ac.uk>); Thu, 12 Oct 2006 01:08:58 +0100
In-Reply-To: <1160610784.7763.3.camel@pcjc2lap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


> Wierdly, I've lost the Battery/AC adapter status monitoring again, with
> or without ec_intr=0.

> Gets odder!

Ok,

Nearing completion of this tale I think..

Turns out there is a known problem with psmouse, which leaves the
system / ACPI / something in a bad state if psmouse is loaded before
shutdown or reboot. Googling tells me that either removing batteries, AC
etc.. before powering up, booting Windows, or shutting down Linux with
psmouse removed, will "fix" the symptoms.

Magic...

Removing psmouse before boot from the init scripts, I reboot (no
ec_intr=0), and not only does the battery status work properly, the CPU
frequency scaling also works up to the CPU's maximum 2Ghz (which it
never did before, it only ever reached 1.6Ghz).

I'm now inclined to wonder if the F.08 BIOS might have worked ok, and
provided the appropriate SSDT for CPU speed control, had the psmouse
module been removed before reboot.

Unless anyone is keen to know the results, I'm not that motivated to
find out (by upgrading the bios again), as I'm not keen to either wear
out the bios flash chip, or have a random corruption during an update.

Thanks for all the help so far,

Regards

Peter Clifton.


