From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Thu, 10 Jul 2008 14:19:04 +0200
Message-ID: <200807101419.08524.trenn@suse.de>
References: <200807031809.03172.trenn@suse.de> <200807101336.08035.trenn@suse.de> <20080710115317.GA7013@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080710115317.GA7013@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thursday 10 July 2008 13:53:17 Matthew Garrett wrote:
> On Thu, Jul 10, 2008 at 01:36:04PM +0200, Thomas Renninger wrote:
> > On Thursday 10 July 2008 13:19:00 Matthew Garrett wrote:
> > > No, I said that on Thinkpads with a PWM method, the PWM method has to
> > > be called in order to avoid the delay. There's no need for a blacklist.
> >
> > Ok.
> > I just got a report that Dells must not use the video driver:
> > https://bugzilla.novell.com/show_bug.cgi?id=404627
> >
> > They have a really ugly dcdbas driver which issues SMIs triggered from
> > userspace.
>
> If the ACPI video driver has bound, then using the dcdbas mechanism for
> backlight control is incorrect. I wasn't aware that any Dells actually
> implemented that. The correct thing is for userspace to stop using
> dcdbas if a real backlight control is available, not to cripple the
> ACPI video driver.

Yes, I agree.
Anyway, given the fact that video.ko was rather broken all the time, a 
reasonable solution for now is to exclude Dells from using it.

The dcdbas driver writers (I expect Dell itself has its finger on this one) 
should get informed and solution will be found. video_detect.c probably will 
help here.

        Thomas
