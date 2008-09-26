From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Is rfkill class really appropriate for eeepc-laptop?
Date: Fri, 26 Sep 2008 13:48:05 -0300
Message-ID: <20080926164805.GC30729@khazad-dum.debian.net>
References: <20080918133144.GA4338@silver.sucs.org> <48D564A8.7030009@xandros.com> <20080921102246.GA27071@silver.sucs.org> <48D660C5.6070204@xandros.com> <48D69052.1040908@tuffmail.co.uk> <48D6AC5E.70502@xandros.com> <48DCE881.5000501@tuffmail.co.uk> <20080926135517.GA6273@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57555 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461AbYIZQsL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Sep 2008 12:48:11 -0400
Content-Disposition: inline
In-Reply-To: <20080926135517.GA6273@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, corentincj@iksaif.net, Woody Suwalski <woodys@xandros.com>, Sitsofe Wheeler <sits@sucs.org>, acpi4asus-user@lists.sourceforge.net, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, 26 Sep 2008, Matthew Garrett wrote:
> On Fri, Sep 26, 2008 at 02:49:53PM +0100, Alan Jenkins wrote:
> > I was wrong to say that rfkill support was already in mainline.  But it
> > is introduced by Matthew's patch "eeepc-laptop: Use standard
> > interfaces", as posted and reviewed on the linux-acpi list.  I think
> > this is a bad idea.  Surely the whole point of rfkill is to let
> > NetworkManager do power management *without* having to do different
> > things for different laptops?
> 
> No, it's to use allow the OS to control whatever mechanism the platform 
> provides for making the radio stop transmitting. The fact that this is, 
> uh, "interestingly" implemented on the Eee doesn't alter that. We should 
> just sort out the hotplug code...

Almost correct.  rfkill is for making the wireless transmitters stop
EMITTING ENERGY.  If one just stops sending data but, e.g., a carrier is
still being transmitted, the device is NOT rfkill'ed... it is just silenced
or something like that.

Anyway, Matthew is quite right that it is well within rfkill's intended
usage to power off and disconnect from the host bus the entire device in
order to shut down energy emissions.

However, if the hardware/platform can do it in a less heavy-handed way, that
would be vastly prefered over kicking the device off the bus and powering it
off, as far as rfkill is concered.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
