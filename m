From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: suspend: don't let device _PS3 failure prevent
	suspend
Date: Mon, 11 May 2009 10:43:02 +0800
Message-ID: <1242009782.3773.139.camel@localhost.localdomain>
References: <bug-13243-10286@http.bugzilla.kernel.org/>
	 <20090505150138.92f3ecd6.akpm@linux-foundation.org>
	 <4A02000D.9030400@gmx.net> <200905061616.36707.bjorn.helgaas@hp.com>
	 <1241660638.3773.90.camel@localhost.localdomain> <4A0330E3.9060909@gmx.net>
	 <alpine.LFD.2.00.0905080037240.20287@localhost.localdomain>
	 <20090508122354.GA30672@khazad-dum.debian.net>  <4A073D92.5060904@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:39327 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319AbZEKClH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 May 2009 22:41:07 -0400
In-Reply-To: <4A073D92.5060904@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "cedric@belbone.be" <cedric@belbone.be>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2009-05-11 at 04:48 +0800, Witold Szczeponik wrote:
> Henrique de Moraes Holschuh schrieb:
> 
> > On Fri, 08 May 2009, Len Brown wrote:
> >> Or perhaps we should just shrug off the _PS3 failure
> >> and carry on with _DIS like we used to -- which is
> >> what this patch does.
> > 
> > Maybe "printk and carry on" would be better?
> > 
> 
> And there is very similar code just a few lines above: where we turn on 
> the device by setting it to D0.  There, too, we may want to skip the 
> check whether or not the transition was successful or not.
What you said is right.
It sounds reasonable that we skip the power state check while transiting
it to D0 state.

In fact the power state check can be skipped by adding the boot option
of "acpi.power_nocheck=1".

thanks.
> 
> --- Witold

