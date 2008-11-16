From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Sun, 16 Nov 2008 15:44:55 -0600
Message-ID: <200811161544.56367.trenn@suse.de>
References: <200811081637.45099.arvidjaar@mail.ru> <20081115184900.GA10685@srcf.ucam.org> <20081116125114.GB29981@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:60062 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156AbYKPVpA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Nov 2008 16:45:00 -0500
In-Reply-To: <20081116125114.GB29981@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sunday 16 November 2008 06:51:14 am Henrique de Moraes Holschuh wrote:
> On Sat, 15 Nov 2008, Matthew Garrett wrote:
> > Ok, so they can get unsynchronised. I agree with Thomas that it's
> > desirable to remove one of them in that case. As you and Len have
> > pointed out, the difficulty is in knowing which one to remove.
>
> May I point out the obvious, and *very* annoying fact?
>
> It is clear by now that if we want to solve all border conditions nicely,
> we will need centralized control of backlight interfaces to broker between
> platform-specific drivers and ACPI generic.
>
> My idea is: separate them in two layers.  Have the "backends" (ACPI generic
> and platform specific drivers) register parameters with a "frontend".  The
> "frontend" exposes a *single* backlight interface.  The backends expose
> NOTHING (or at most a deprecated interface if it won't break things).
>
> Backlight interfaces can have their parameters updated at runtime, so we do
> just that if the frontend has to switch backends (i.e. due to module
> loading/unloading).  Make sure the backend is informed when it is
> connected/disconnected from driving the backlight.
>
> Use an intelligent setup to select which backend should be driving the
> backlight.  e.g: the backends provide a priority information and a quality
> information (priority is low-medium-high.  Quality is the number of levels,
> adjusted up or down if you know there is something special about it that
> should lower or rise the quality).
>
> If there is only one backend loaded, select that.  If there are more than
> one, select the highest priority one.  When the priority of the backends is
> the same, select the one with the highest quality. When quality and
> priority are the same, select the generic ACPI.
>
> Priority should always be medium, except when you know for sure that you
> need to do something special for an specific platform/box.
>
> Any other ideas, comments?

I would not add such complexity for a problem which isn't a real problem.
IMO we should either:
   1) Just do nothing and use video.ko even for Toshibas which only provide
       3 brightness states.
   2) DMI blacklist for Toshiba in general to use toshiba_laptop for
       brightness switching.

The whole problem of vendor.ko via video.ko is similar to
"should acpi be enabled or not" for about 5 year old machines.
It took years to find out most corner cases.
But if you have the wrong assumption made there the machine is not booting.

For the brightness level it's something else. A short documentation into the 
right forum/mailing list and everybody can google the 
acpi_backlight=vendor/video boot param in a second on his already running 
machine and is happy.

There where we know things are broken for a default choice we can add a short 
dmi blacklist.
The question is, are these 3 brightness levels to be considered as broken.

IMO it is something 95% of all toshiba users won't care, the brightness level 
can be dimmed for battery usage and if they care, they can still easily tune 
it. 
I very much expect that newer Toshibas export more brightness levels via 
video.ko (does someone have a new one and can double check?) and at some time 
the Toshiba specific functions may even vanish. Therefore I would prefer to 
not do an exception here and go for 1(see above).

   Thomas
