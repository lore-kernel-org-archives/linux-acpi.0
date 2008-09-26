From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Is rfkill class really appropriate for eeepc-laptop?
Date: Fri, 26 Sep 2008 15:17:41 +0100
Message-ID: <20080926141741.GA6671@srcf.ucam.org>
References: <20080918133144.GA4338@silver.sucs.org> <48D564A8.7030009@xandros.com> <20080921102246.GA27071@silver.sucs.org> <48D660C5.6070204@xandros.com> <48D69052.1040908@tuffmail.co.uk> <48D6AC5E.70502@xandros.com> <48DCE881.5000501@tuffmail.co.uk> <20080926135517.GA6273@srcf.ucam.org> <48DCEE58.5060004@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36758 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbYIZOSD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 10:18:03 -0400
Content-Disposition: inline
In-Reply-To: <48DCEE58.5060004@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: corentincj@iksaif.net, Woody Suwalski <woodys@xandros.com>, Sitsofe Wheeler <sits@sucs.org>, acpi4asus-user@lists.sourceforge.net, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, Sep 26, 2008 at 03:14:48PM +0100, Alan Jenkins wrote:
> Matthew Garrett wrote:
> > No, it's to use allow the OS to control whatever mechanism the platform 
> > provides for making the radio stop transmitting. The fact that this is, 
> > uh, "interestingly" implemented on the Eee doesn't alter that.
> 
> So rfkill should be allowed to mean "entire PCI device goes away,
> network interface will vanish" - just so long as it comes back correctly
> when re-enabled :-).

Sure, if that's how the platform implements it. This is how almost every 
bluetooth rfkill interface works, so applications should be able to 
cope.

> >  We should just sort out the hotplug code...
> >   
> 
> Ok.  I have a little knowledge, I'll see if I can be dangerous.  My real
> question was, is it safe to merge your rfkill support before this is
> sorted out?

I don't see why not. It works on various versions of the eee, and unless 
anything actually pokes it people can carry on using their bizarro 
userspace scripts. I'm working with the PCI guys on handling the hotplug 
case sanely. It may be possible to special case this in eeepc-laptop, 
though I'd prefer a more generic solution.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
