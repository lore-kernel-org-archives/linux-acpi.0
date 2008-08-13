From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.27-rc1: critical thermal shutdown on thinkpad x60
Date: Wed, 13 Aug 2008 17:42:42 -0300
Message-ID: <20080813204242.GC27546@khazad-dum.debian.net>
References: <20080806090246.GA1572@elf.ucw.cz> <87bq046cht.fsf@basil.nowhere.org> <20080812094135.GA1565@elf.ucw.cz> <20080812105409.GA1366@one.firstfloor.org> <48A16EFC.1050401@redhat.com> <20080812112602.GA2948@elf.ucw.cz> <20080813201359.GA27546@khazad-dum.debian.net> <20080813202801.GC8861@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49229 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751654AbYHMUms (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Aug 2008 16:42:48 -0400
Content-Disposition: inline
In-Reply-To: <20080813202801.GC8861@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Milan Broz <mbroz@redhat.com>, Andi Kleen <andi@firstfloor.org>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Wed, 13 Aug 2008, Pavel Machek wrote:
> On Wed 2008-08-13 17:13:59, Henrique de Moraes Holschuh wrote:
> > On Tue, 12 Aug 2008, Pavel Machek wrote:
> > > > Now, the CPU cores remains on 1.67GHz and fan is unable to cool them properly
> > > > under heavy load (even if I set "level disengaged" through thinkpad fan control,
> > > > temperature sensor shows after a while 128 C (probably not real temp,
> > > > I expect some critical flag => and it properly switch off the
> > > > system...)
> > > 
> > > How do you control fans? I could not get anything but -EINVAL from IBM
> > > ACPI driver :-(.
> > 
> > thinkpad-acpi will regard 128 and -128 as invalid sensors, because that's
> > how they are used in some BIOSes (and ECs).  We used to bother only with
> > -128, but Lenovo did something wierd in one of the EC firmwares and I had to
> > add +128 too.  That masks the "help, I am melting" reading.
> 
> It was simpler than that. I did not pass "fan_control=1" option.
> 
> (Actually... I do not think that option is needed. If fan control is
> known to work, it should be just enabled...)

I require explicit user permission to activate knobs that are that
dangerous, and actively frowned upon by the manufacturer.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
