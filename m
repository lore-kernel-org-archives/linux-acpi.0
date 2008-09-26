From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Is rfkill class really appropriate for eeepc-laptop?
Date: Fri, 26 Sep 2008 14:55:17 +0100
Message-ID: <20080926135517.GA6273@srcf.ucam.org>
References: <20080918133144.GA4338@silver.sucs.org> <48D564A8.7030009@xandros.com> <20080921102246.GA27071@silver.sucs.org> <48D660C5.6070204@xandros.com> <48D69052.1040908@tuffmail.co.uk> <48D6AC5E.70502@xandros.com> <48DCE881.5000501@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35800 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbYIZNzm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 09:55:42 -0400
Content-Disposition: inline
In-Reply-To: <48DCE881.5000501@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: corentincj@iksaif.net, Woody Suwalski <woodys@xandros.com>, Sitsofe Wheeler <sits@sucs.org>, acpi4asus-user@lists.sourceforge.net, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, Sep 26, 2008 at 02:49:53PM +0100, Alan Jenkins wrote:

> I was wrong to say that rfkill support was already in mainline.  But it
> is introduced by Matthew's patch "eeepc-laptop: Use standard
> interfaces", as posted and reviewed on the linux-acpi list.  I think
> this is a bad idea.  Surely the whole point of rfkill is to let
> NetworkManager do power management *without* having to do different
> things for different laptops?

No, it's to use allow the OS to control whatever mechanism the platform 
provides for making the radio stop transmitting. The fact that this is, 
uh, "interestingly" implemented on the Eee doesn't alter that. We should 
just sort out the hotplug code...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
