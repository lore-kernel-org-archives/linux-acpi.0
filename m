From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: suspend: don't let device _PS3 failure prevent suspend
Date: Mon, 11 May 2009 17:21:09 +0200
Message-ID: <200905111721.10166.rjw@sisk.pl>
References: <bug-13243-10286@http.bugzilla.kernel.org/> <4A073D92.5060904@gmx.net> <1242009782.3773.139.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34133 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbZEKPVm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 May 2009 11:21:42 -0400
In-Reply-To: <1242009782.3773.139.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Witold Szczeponik <Witold.Szczeponik@gmx.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "cedric@belbone.be" <cedric@belbone.be>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Monday 11 May 2009, yakui_zhao wrote:
> On Mon, 2009-05-11 at 04:48 +0800, Witold Szczeponik wrote:
> > Henrique de Moraes Holschuh schrieb:
> > 
> > > On Fri, 08 May 2009, Len Brown wrote:
> > >> Or perhaps we should just shrug off the _PS3 failure
> > >> and carry on with _DIS like we used to -- which is
> > >> what this patch does.
> > > 
> > > Maybe "printk and carry on" would be better?
> > > 
> > 
> > And there is very similar code just a few lines above: where we turn on 
> > the device by setting it to D0.  There, too, we may want to skip the 
> > check whether or not the transition was successful or not.
> What you said is right.
> It sounds reasonable that we skip the power state check while transiting
> it to D0 state.
> 
> In fact the power state check can be skipped by adding the boot option
> of "acpi.power_nocheck=1".

Can we avoid adding the boot option?  I'd very much prefer not to add boot
options if not really necessary.

Rafael
