From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: [PATCH] allow the highest frequency if bios think so.
Date: Tue, 21 Nov 2006 11:04:36 +0000
Message-ID: <1164107076.5516.33.camel@pcjc2lap>
References: <20061121103042.GI4945@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:5043 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030848AbWKULFU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Nov 2006 06:05:20 -0500
In-Reply-To: <20061121103042.GI4945@poupinou.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: davej@redhat.com, cpufreq@lists.linux.org.uk, linux-acpi@vger.kernel.org

On Tue, 2006-11-21 at 11:30 +0100, Bruno Ducrot wrote:
> Hi all,
> 
> processor_perflib.c::acpi_processor_ppc_notifier() check if the value
> returned by the processor's _PPC method is 0 and return failed if so.
> This is wrong since 0 indicate that the bios think the processor can
go
> to the highest frequency.  This patch for example fix the HP NX 6125
to
> allow its highest frequency to be available.

I don't know about the HP NX 6125, but on my nc 6320, you have to rmmod
psmouse before you shutdown or reboot the computer, otherwise something
upsets the BIOS and it won't run at full speed on next boot up.

Can't hurt to give it a try. The other method to get it working again is
to remove the AC adaptor and the battery for a few seconds, then
re-insert and power up.

Bootup time is also much faster if the psmouse was rmmod'd before
shutdown, or the power was completely removed as above.

Weired indeed!

Peter Clifton

