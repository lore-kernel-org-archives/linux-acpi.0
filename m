From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Thu, 10 Jul 2008 13:24:54 +0100
Message-ID: <20080710122454.GA7584@srcf.ucam.org>
References: <200807031809.03172.trenn@suse.de> <200807101336.08035.trenn@suse.de> <20080710115317.GA7013@srcf.ucam.org> <200807101419.08524.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200807101419.08524.trenn@suse.de>
Sender: linux-next-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 10, 2008 at 02:19:04PM +0200, Thomas Renninger wrote:
> On Thursday 10 July 2008 13:53:17 Matthew Garrett wrote:
> > If the ACPI video driver has bound, then using the dcdbas mechanism for
> > backlight control is incorrect. I wasn't aware that any Dells actually
> > implemented that. The correct thing is for userspace to stop using
> > dcdbas if a real backlight control is available, not to cripple the
> > ACPI video driver.
> 
> Yes, I agree.
> Anyway, given the fact that video.ko was rather broken all the time, a 
> reasonable solution for now is to exclude Dells from using it.

No, the problem was that the backlight was simultaneously being altered 
by two pieces of code. kpowersave is doing the backlight control via hal 
(I assume), and hal should simply not provide the Dell backlight control 
on systems that have ACPI video backlight control. There's no need to 
have this policy in the kernel.

> The dcdbas driver writers (I expect Dell itself has its finger on this one) 
> should get informed and solution will be found. video_detect.c probably will 
> help here.

It's a userspace problem and a straightforward userspace solution.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
