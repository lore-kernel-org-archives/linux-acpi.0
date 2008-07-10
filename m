From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Thu, 10 Jul 2008 12:19:00 +0100
Message-ID: <20080710111900.GA6303@srcf.ucam.org>
References: <200807031809.03172.trenn@suse.de> <200807101300.37586.trenn@suse.de> <20080710110941.GC5017@srcf.ucam.org> <200807101315.21904.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200807101315.21904.trenn@suse.de>
Sender: linux-next-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>, Hong Liu <hong.liu@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 10, 2008 at 01:15:18PM +0200, Thomas Renninger wrote:
> On Thursday 10 July 2008 13:09:41 Matthew Garrett wrote:
> > No I didn't. Please don't do this - we have all the code needed to do it
> > properly, so there's no need to use the thinkpad_acpi driver for
> > backlight control on this hardware.
> Ok.
> But haven't you said there are ThinkPad BIOSes missing a specific ACPI part 
> and therefore you had the delay?
> If you could give me a dmidecode output, I like to add it.
> It would be great to have an example in the blacklist, then things are much 
> easier for others...

No, I said that on Thinkpads with a PWM method, the PWM method has to be 
called in order to avoid the delay. There's no need for a blacklist.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
