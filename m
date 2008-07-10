From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Thu, 10 Jul 2008 13:36:04 +0200
Message-ID: <200807101336.08035.trenn@suse.de>
References: <200807031809.03172.trenn@suse.de> <200807101315.21904.trenn@suse.de> <20080710111900.GA6303@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080710111900.GA6303@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>, Hong Liu <hong.liu@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thursday 10 July 2008 13:19:00 Matthew Garrett wrote:
> On Thu, Jul 10, 2008 at 01:15:18PM +0200, Thomas Renninger wrote:
> > On Thursday 10 July 2008 13:09:41 Matthew Garrett wrote:
> > > No I didn't. Please don't do this - we have all the code needed to do
> > > it properly, so there's no need to use the thinkpad_acpi driver for
> > > backlight control on this hardware.
> >
> > Ok.
> > But haven't you said there are ThinkPad BIOSes missing a specific ACPI
> > part and therefore you had the delay?
> > If you could give me a dmidecode output, I like to add it.
> > It would be great to have an example in the blacklist, then things are
> > much easier for others...
>
> No, I said that on Thinkpads with a PWM method, the PWM method has to be
> called in order to avoid the delay. There's no need for a blacklist.

Ok.
I just got a report that Dells must not use the video driver:
https://bugzilla.novell.com/show_bug.cgi?id=404627

They have a really ugly dcdbas driver which issues SMIs triggered from 
userspace.
Hmm, to do it correctly, I have to match against the alias of the dcdbas 
driver:
MODULE_ALIAS("dmi:*:[bs]vnD[Ee][Ll][Ll]*:*");
but matching for Dell should be enough.

Also not nice is that the video driver probably should not be loaded at all in 
this case.
Hmm, maybe I should check for !video_backlight_support 
&& !video_display_output_support and then do not load the video driver at 
all, it shouldn't have any functionality then, not sure...

   Thomas
