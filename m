From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: [PATCH] allow the highest frequency if bios think so.
Date: Tue, 21 Nov 2006 12:11:58 +0100
Message-ID: <20061121111158.GJ4945@poupinou.org>
References: <20061121103042.GI4945@poupinou.org> <1164107076.5516.33.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:36868 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1030869AbWKULMQ
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Nov 2006 06:12:16 -0500
Content-Disposition: inline
In-Reply-To: <1164107076.5516.33.camel@pcjc2lap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: davej@redhat.com, linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk

On Tue, Nov 21, 2006 at 11:04:36AM +0000, Peter Clifton wrote:
> On Tue, 2006-11-21 at 11:30 +0100, Bruno Ducrot wrote:
> > Hi all,
> > 
> > processor_perflib.c::acpi_processor_ppc_notifier() check if the value
> > returned by the processor's _PPC method is 0 and return failed if so.
> > This is wrong since 0 indicate that the bios think the processor can
> go
> > to the highest frequency.  This patch for example fix the HP NX 6125
> to
> > allow its highest frequency to be available.
> 
> I don't know about the HP NX 6125, but on my nc 6320, you have to rmmod
> psmouse before you shutdown or reboot the computer, otherwise something
> upsets the BIOS and it won't run at full speed on next boot up.

The proposed patch fix exactly this one on the HP NX 6125.

> Can't hurt to give it a try. The other method to get it working again is
> to remove the AC adaptor and the battery for a few seconds, then
> re-insert and power up.
> 
> Bootup time is also much faster if the psmouse was rmmod'd before
> shutdown, or the power was completely removed as above.

Can't tell for this bootup time issue though.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
