From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH - 2.6.19 -0/1] Backport of psmouse suspend/shutdown
	cleanups
Date: Wed, 28 Feb 2007 17:46:04 +0100
Message-ID: <1172681164.10619.516.camel@d36.suse.de>
References: <1172077685.10619.101.camel@d36.suse.de>
	 <d120d5000702210926j7e7f1ccjb8c2689640b870e8@mail.gmail.com>
	 <1172148739.10619.196.camel@d36.suse.de>
	 <d120d5000702220702r44894a51lfb5499b5c59d8563@mail.gmail.com>
	 <1172499672.10619.346.camel@d36.suse.de>
	 <d120d5000702260634g3250e32ej3619a5f584f204af@mail.gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:34289 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbXB1QqG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Feb 2007 11:46:06 -0500
In-Reply-To: <d120d5000702260634g3250e32ej3619a5f584f204af@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

On Mon, 2007-02-26 at 09:34 -0500, Dmitry Torokhov wrote:
> Hi Thomas,
> 
> On 2/26/07, Thomas Renninger <trenn@suse.de> wrote:
> > On Thu, 2007-02-22 at 10:02 -0500, Dmitry Torokhov wrote:
> > >
> > > Hope this makes sense (I must admit it makes little sense to me ;) ).
> >
> > Same for me at the beginning.
> > I tracked two of the HP problems (wrong temperature, wrong _PPC value)
> > down to wrong EC reads -> BIOS issue.
> >
> > Someone (this is the guy who actually solved this) reported that
> > unloading psmouse helps. When I saw this report confirmed by other
> > people a .shutdown workaround was easy and got also confirmed working...
> >
> > And now it even makes a bit sense...
> > There is a little microprocessor (Embedded Controller) pre-processing
> > sensor or other data which gets accessed via ACPI. This one also access
> > mouse/keyboard hardware (described a bit in ACPI specs).
> 
> Yes, I am aware that KBC is usually emulated by EC chip nowadays, what
> does not really makes sense to me is how crazy the firmware is.
> 
> ...
> > FYI:
> > You might stumble again over the EC in future...
> > I saw reports where mouse jittering or similar bugs where fixed in
> > drivers/acpi/ec.c
> > If trying ec_intr=0 boot param, not loading any ACPI modules or the big
> > hammer: acpi=off helps to solve mouse or keyboard problems it's probably
> > Embedded Controller related (which might need a fix in ec.c, AML or EC
> > BIOS code (in this case we seem to have the latter problem :) )...).
> >
> 
> Yep, seen that, except for AML workarounds. Do you have any examples?
> Although there seem to be lees complaints about mice jittering
> nowadays... Or maybe they simply got tired of complaining ;)

I remember one mouse jittering issue got fixed by BIOS update, but I
don't know whether they fixed the EC firmware, modified EC reads/writes
in AML or whatever...

Reducing thermal polling or ACPI (EC) activity in general could also
help, therefore I expect workarounds in AML could be an option.
	
I also remember some cleanups in drivers/acpi/ec.c (some time ago) that
fixed up some machines...


    Thomas

