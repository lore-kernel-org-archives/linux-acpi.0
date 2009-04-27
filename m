From: Thomas Renninger <trenn@suse.de>
Subject: Re: Incorrect ACPI blacklisting of ASUS P4B266 ?
Date: Mon, 27 Apr 2009 12:18:02 +0200
Message-ID: <200904271218.02906.trenn@suse.de>
References: <87k5691x3y.fsf@olivierberger.com> <200904021502.31021.trenn@suse.de> <87ws98r0fl.fsf@olivierberger.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:39441 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbZD0KSF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Apr 2009 06:18:05 -0400
In-Reply-To: <87ws98r0fl.fsf@olivierberger.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olivier Berger <oberger@ouvaton.org>
Cc: linux-acpi@vger.kernel.org

On Saturday 25 April 2009 21:35:42 Olivier Berger wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi.
> 
> Following advice from Thomas Renninger, I hereby propose a patch for the
> ACPI blacklisting kernel code, that I've successfully applied to kernel
> 2.6.26-15, that allows ACPI detection on Asus P4B266 mainboards.
Hmm, there seem to be different models of this motherboard series:
P4B266
P4B266-C
P4B266-E
P4B266-M
P4B266-SE

P4B266 and P4B266-SE seem to have a similar BIOS history and the latest
for both is: Beta Version 1011.003 

The rest has a similar version string, but different latest BIOS versions
(e.g. 1007)

The dmi blacklisting currently done in the kernel is probably matching
all of above and is rather unfortunate.
We could have:
  - A BIOS update which makes all of above models work with acpi(=force)
    well. Then your patch is perfect.

  - One or more of above (latest) BIOSes does not work well with acpi=force
    still.
    Then we'd get regressions and some people will moan about that and
    the patch will get reverted. In this case we should find out which
    kind of BIOS/mainboard it is and enhance the blacklisting to only
    match this(these) -> dmidecode is needed to be able to blacklist more
    fine grained.

> Maybe there could be a smarter version that would allow blacklisting for
> same mainboards with older BIOS versions than the one I'm using, but I
> don't know if/how that'd be possible. So the patch I propose is pretty
> obvious.
> 
> FYI, here are some reports that mention acpi=force working succesfully
> for P4B266 mainboards (in english and german) :
> 
> http://forums.fedoraforum.org/showpost.php?p=669615&postcount=5 / http://fedoraforum.org/forum/showpost.php?p=669615&postcount=5
> https://lists.ubuntu.com/archives/kernel-bugs/2006-November/023486.html / https://bugs.launchpad.net/linux/+bug/43961/comments/145
> http://forum.ubuntuusers.de/topic/automatische-abschaltung/#post-249151
> http://www.pc-forum24.de/suse-system-installieren/3031-suse-10-2-laesst-sich-nicht-ausschalten.html#post13729
> 
> I hope this won't break things for different BIOS versions than mine,
That's the risk and we should try to find out more first.

I wonder whether it's worth that at all, one of the latest BIOSes is from:
2003/06/10

> and that this will on the other hand allow lots of users to benefit from
> working ACPI.
It should be best if you state in above references that these guys
must use acpi=force.
Others should find it then via google.
That's the easiest and safest way.
I tried to find out who and why this got added, but this exists even before
git history...


     Thomas
