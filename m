From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Thu, 10 Jul 2008 14:48:12 +0200
Message-ID: <200807101448.16662.trenn@suse.de>
References: <200807031809.03172.trenn@suse.de> <200807101419.08524.trenn@suse.de> <20080710122454.GA7584@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43552 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892AbYGJMsT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jul 2008 08:48:19 -0400
In-Reply-To: <20080710122454.GA7584@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>

On Thursday 10 July 2008 14:24:54 Matthew Garrett wrote:
> On Thu, Jul 10, 2008 at 02:19:04PM +0200, Thomas Renninger wrote:
> > On Thursday 10 July 2008 13:53:17 Matthew Garrett wrote:
> > > If the ACPI video driver has bound, then using the dcdbas mechanism for
> > > backlight control is incorrect. I wasn't aware that any Dells actually
> > > implemented that. The correct thing is for userspace to stop using
> > > dcdbas if a real backlight control is available, not to cripple the
> > > ACPI video driver.
> >
> > Yes, I agree.
> > Anyway, given the fact that video.ko was rather broken all the time, a
> > reasonable solution for now is to exclude Dells from using it.
>
> No, the problem was that the backlight was simultaneously being altered
> by two pieces of code. kpowersave is doing the backlight control via hal
> (I assume), and hal should simply not provide the Dell backlight control
> on systems that have ACPI video backlight control. There's no need to
> have this policy in the kernel.
Do you know Dells working with the video.ko driver?

If you tell me video.ko, best with an IGD device and without one is working 
there, it can be removed. Even then talking with dcdbas developers how to 
inform their user space app first is a good idea.

As Dell is cooking their own soup here and the dcdbas driver was reported to 
work correctly with ACPI brightness functions in BIOS it is ok to blacklist 
Dells here until the first test reports are coming in telling us that 
video.ko is actually working correctly there.
Testing will be easy via boot param.

I will not risk again that this whole bunch of our patches will be reverted 
on -rc6 again, because a Dell user is reporting a backlight regression.
We then have the same situation we had when the "check for physical device was 
removed": The implementation is wrong but worked. The implementation is 
right, but does not work on a specific machine -> regression -> revert.

      Thomas
