From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP Compaq nc6320 - Booting on battery power causes softlock
Date: Wed, 17 Jan 2007 14:21:59 +0000
Message-ID: <1169043719.6273.8.camel@localhost>
References: <1169002596.29755.5.camel@localhost>
	 <3877989d0701161904u6ef2b931t99b79d92dd974f2a@mail.gmail.com>
	 <200701162215.34627.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:57792 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323AbXAQOWW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jan 2007 09:22:22 -0500
In-Reply-To: <200701162215.34627.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Luming Yu <luming.yu@gmail.com>, linux-acpi@vger.kernel.org

On Tue, 2007-01-16 at 22:15 -0500, Len Brown wrote:
> try also "apm=off" -- since the ACPI/APM dependency checking
> is currently broken in some configs.
> 
> On Tuesday 16 January 2007 22:04, Luming Yu wrote:
> > The first thing is to make sure you are running the latest bios, kernel.
> > Then, you need to sort out the kernel component/modules/drivers that
> > cause the problem.
> > If you guess it is ACPI issue, pleas test boot option acpi=off to see
> > if the problem goes away. If you guess it is battery issue, please
> > remove battery module, etc.
> > Please don't forget to enter a bug in bugzilla.kernel.org.
> > 
> > Thanks,
> > Luming

Ok, I've tested acpi=off and apm=off with the stock Ubuntu kernel. It
didn't softlock with either, but I'll try to use one of the two when
booting now to ensure it is consistent.

with acpi=off, there was a backtrace printed from an unloved IRQ11, and
the sound card wasn't particularly happy. These HP laptops seem very
picky - perhaps I should buy an IBM next time for linux!

I've filed a bug, #7840, http://bugzilla.kernel.org/show_bug.cgi?id=7840

It is under ACPI/Other. Attached to that bug is dmesg output from the
normal AC boot, and battery boots with acpi=off, api=off, also an
acpidump output from the normal AC boot.

I will check the bios, and vanilla kernel tests when I get chance.
Unfortunately, it seems quite hard to get a kernel config which exactly
matches a stock Ubuntu one (for keeping as few variables changed as
possible). I can recompile a kernel source deb for Ubuntu quite happily,
but it produces a huge number of versions, and takes many many hours
(brings me back to using linux on a [34]86 :))

Thanks for your input Luming, Len.

Regards,

Peter Clifton


