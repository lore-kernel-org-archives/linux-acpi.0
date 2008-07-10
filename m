From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Thu, 10 Jul 2008 13:58:44 +0100
Message-ID: <20080710125844.GB8561@srcf.ucam.org>
References: <200807031809.03172.trenn@suse.de> <200807101419.08524.trenn@suse.de> <20080710122454.GA7584@srcf.ucam.org> <200807101448.16662.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46770 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbYGJM6s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jul 2008 08:58:48 -0400
Content-Disposition: inline
In-Reply-To: <200807101448.16662.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>

On Thu, Jul 10, 2008 at 02:48:12PM +0200, Thomas Renninger wrote:
> On Thursday 10 July 2008 14:24:54 Matthew Garrett wrote:
> > On Thu, Jul 10, 2008 at 02:19:04PM +0200, Thomas Renninger wrote:
> > > Yes, I agree.
> > > Anyway, given the fact that video.ko was rather broken all the time, a
> > > reasonable solution for now is to exclude Dells from using it.
> >
> > No, the problem was that the backlight was simultaneously being altered
> > by two pieces of code. kpowersave is doing the backlight control via hal
> > (I assume), and hal should simply not provide the Dell backlight control
> > on systems that have ACPI video backlight control. There's no need to
> > have this policy in the kernel.
> Do you know Dells working with the video.ko driver?

Presumably the Inspiron 640M, since otherwise there's no way that that 
bug could trigger.

> If you tell me video.ko, best with an IGD device and without one is working 
> there, it can be removed. Even then talking with dcdbas developers how to 
> inform their user space app first is a good idea.

The userspace app that needs fixing is hal. I'm already working on that.

> As Dell is cooking their own soup here and the dcdbas driver was reported to 
> work correctly with ACPI brightness functions in BIOS it is ok to blacklist 
> Dells here until the first test reports are coming in telling us that 
> video.ko is actually working correctly there.
> Testing will be easy via boot param.

No, really, let's just fix the problem properly.

> I will not risk again that this whole bunch of our patches will be reverted 
> on -rc6 again, because a Dell user is reporting a backlight regression.
> We then have the same situation we had when the "check for physical device was 
> removed": The implementation is wrong but worked. The implementation is 
> right, but does not work on a specific machine -> regression -> revert.

I've no idea at all why you think this is a kernel issue.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
