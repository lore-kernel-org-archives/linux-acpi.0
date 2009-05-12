From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: suspend: don't let device _PS3 failure prevent
	suspend
Date: Tue, 12 May 2009 08:48:25 +0800
Message-ID: <1242089305.3773.198.camel@localhost.localdomain>
References: <bug-13243-10286@http.bugzilla.kernel.org/>
	 <4A073D92.5060904@gmx.net>
	 <1242009782.3773.139.camel@localhost.localdomain>
	 <200905111721.10166.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37220 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755501AbZELAqS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 May 2009 20:46:18 -0400
In-Reply-To: <200905111721.10166.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Witold Szczeponik <Witold.Szczeponik@gmx.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "cedric@belbone.be" <cedric@belbone.be>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2009-05-11 at 23:21 +0800, Rafael J. Wysocki wrote:
> On Monday 11 May 2009, yakui_zhao wrote:
> > On Mon, 2009-05-11 at 04:48 +0800, Witold Szczeponik wrote:
> > > Henrique de Moraes Holschuh schrieb:
> > > 
> > > > On Fri, 08 May 2009, Len Brown wrote:
> > > >> Or perhaps we should just shrug off the _PS3 failure
> > > >> and carry on with _DIS like we used to -- which is
> > > >> what this patch does.
> > > > 
> > > > Maybe "printk and carry on" would be better?
> > > > 
> > > 
> > > And there is very similar code just a few lines above: where we turn on 
> > > the device by setting it to D0.  There, too, we may want to skip the 
> > > check whether or not the transition was successful or not.
> > What you said is right.
> > It sounds reasonable that we skip the power state check while transiting
> > it to D0 state.
> > 
> > In fact the power state check can be skipped by adding the boot option
> > of "acpi.power_nocheck=1".
> 
> Can we avoid adding the boot option?  I'd very much prefer not to add boot
> options if not really necessary.
One is to add it into the DMI power check table so that the default
value of power_nocheck is 1. 

Another is that the default value of power_nocheck is changed to 1
instead of 0. 

In such case the power state check will be skipped in course of power
transition.

Is this OK?
> 
> Rafael

