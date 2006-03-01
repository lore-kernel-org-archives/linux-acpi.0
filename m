From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: system won't wake up, not even reboot
Date: Wed, 1 Mar 2006 12:38:05 -0700
Message-ID: <200603011238.05513.bjorn.helgaas@hp.com>
References: <4402C36F.8080604@ircam.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:9920 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750702AbWCATiJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2006 14:38:09 -0500
In-Reply-To: <4402C36F.8080604@ircam.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Diemo Schwarz <Diemo.Schwarz@ircam.fr>
Cc: linux-acpi@vger.kernel.org

On Monday 27 February 2006 02:16, Diemo Schwarz wrote:
> with kernel 2.6.15 on compaq presario 900 notebook an S3 sleep worked 
> fine but the machine woke up to a black screen.
> 
> The problem is that I can't reboot!  After a hard shutdown (pressing the 
> power button for several seconds), waking the machine up (by a short 
> press on the power button) makes it go into the same state (fan turning, 
> power led on, screen black, can't ping the machine).
> 
> I'm seriously blocked here, is there anything I can do to get the 
> machine back to life?

When you power-up the machine, can you interrupt the boot process
by changing the boot order or entering BIOS setup?  If so, you
should be able to boot from a floppy or CD.

If you can't interrupt the boot process, maybe the machine was not
completely powered-off, and it's really trying to resume from an
S3 sleep.  You could try removing any batteries and AC adapters to
make sure it's powered-off, then try booting again.

[I know next to nothing about suspend/resume, but since nobody else
has stepped up ...]
