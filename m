From: nokos@gmx.net
Subject: Re: why do drivers evaluate _INI?
Date: Tue, 23 Jun 2009 17:17:42 +0200
Message-ID: <1245770262.16646.16.camel@earth.gruber.myown>
References: <200906222359.n5MNxQsN006456@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:40956 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758180AbZFWPSJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2009 11:18:09 -0400
In-Reply-To: <200906222359.n5MNxQsN006456@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Eric Piel <eric.piel@tremplin-utc.net>, Pavel Machek <pavel@suse.cz>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

Am Dienstag, den 23.06.2009, 09:29 +0930 schrieb Jonathan Woithe:
> Hi
> 
> > Why do we have ACPI device drivers evaluating _INI?  That seems
> > like something that should be done by Linux/ACPI, not by the driver.
> > 
> > I see the following drivers using _INI:
> >   drivers/hwmon/hp_accel.c
> >   drivers/platform/x86/fujitsu-laptop.c
> >   drivers/platform/x86/sony-laptop.c
> > 
> > I looked at the git logs where the _INI usage was introduced in
> > these drivers, but none gives enough information for me to understand
> > why.
> 
> I can't shed a lot of light on this from the point of view of
> fujitsu-laptop.
> 
> It appears that the evaluation of _INI was added to fujitsu-laptop as part
> of the patch which added support for hotkeys present on some Fujitsu
> laptops.  This patch was contributed by Peter Gruber - I've added him to the
> CC.  Perhaps he might explain why he added _INI evaluation as part of this
> patch (that is, what problem was encountered which required evaluation of
> _INI).

The hotkey communication between hardware and the drivers is done using
acpi notifies and a (small) ringbuffer in the acpi dsdt code. The
easiest way to assure a consistent. The _INI method simply resets the
internal state of the ringbuffer which seems to be unavailable for
direct manipulation. Another possible path would be to read and discard
the ringbuffer on module load to ensure a consistent state.  

Peter

