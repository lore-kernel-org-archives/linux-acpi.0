From: Olivier Berger <oberger@ouvaton.org>
Subject: Re: Incorrect ACPI blacklisting of ASUS P4B266 ?
Date: Tue, 28 Apr 2009 08:09:16 +0200
Message-ID: <87ocuhqpgz.fsf@olivierberger.com>
References: <87k5691x3y.fsf@olivierberger.com>
	<200904021502.31021.trenn@suse.de> <87ws98r0fl.fsf@olivierberger.com>
	<200904271218.02906.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:57966 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbZD1GJ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2009 02:09:27 -0400
In-Reply-To: <200904271218.02906.trenn@suse.de> (Thomas Renninger's message of "Mon\, 27 Apr 2009 12\:18\:02 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org

Thomas Renninger <trenn@suse.de> writes:

> On Saturday 25 April 2009 21:35:42 Olivier Berger wrote:
>> 
>> Hi.
>> 
>> Following advice from Thomas Renninger, I hereby propose a patch for the
>> ACPI blacklisting kernel code, that I've successfully applied to kernel
>> 2.6.26-15, that allows ACPI detection on Asus P4B266 mainboards.
> Hmm, there seem to be different models of this motherboard series:
> P4B266
> P4B266-C
> P4B266-E
> P4B266-M
> P4B266-SE
>
> P4B266 and P4B266-SE seem to have a similar BIOS history and the latest
> for both is: Beta Version 1011.003 
>

Where is this information available (other than on Asus support site) , btw ?

> The rest has a similar version string, but different latest BIOS versions
> (e.g. 1007)
>
> The dmi blacklisting currently done in the kernel is probably matching
> all of above and is rather unfortunate.
> We could have:
>   - A BIOS update which makes all of above models work with acpi(=force)
>     well. Then your patch is perfect.
>
>   - One or more of above (latest) BIOSes does not work well with acpi=force
>     still.
>     Then we'd get regressions and some people will moan about that and
>     the patch will get reverted. In this case we should find out which
>     kind of BIOS/mainboard it is and enhance the blacklisting to only
>     match this(these) -> dmidecode is needed to be able to blacklist more
>     fine grained.
>

Isn't there any possibility to compare BIOS versions in the blacklisting
code ?

>> Maybe there could be a smarter version that would allow blacklisting for
>> same mainboards with older BIOS versions than the one I'm using, but I
>> don't know if/how that'd be possible. So the patch I propose is pretty
>> obvious.
>> 
>> FYI, here are some reports that mention acpi=force working succesfully
>> for P4B266 mainboards (in english and german) :
>> 
>> http://forums.fedoraforum.org/showpost.php?p=669615&postcount=5 / http://fedoraforum.org/forum/showpost.php?p=669615&postcount=5
>> https://lists.ubuntu.com/archives/kernel-bugs/2006-November/023486.html / https://bugs.launchpad.net/linux/+bug/43961/comments/145
>> http://forum.ubuntuusers.de/topic/automatische-abschaltung/#post-249151
>> http://www.pc-forum24.de/suse-system-installieren/3031-suse-10-2-laesst-sich-nicht-ausschalten.html#post13729
>> 
>> I hope this won't break things for different BIOS versions than mine,
> That's the risk and we should try to find out more first.
>
> I wonder whether it's worth that at all, one of the latest BIOSes is from:
> 2003/06/10

Of course it's an old mainboard... but I suppose there are still quite a
bunch in operation.

>
>> and that this will on the other hand allow lots of users to benefit from
>> working ACPI.
> It should be best if you state in above references that these guys
> must use acpi=force.
> Others should find it then via google.
> That's the easiest and safest way.

Well... adding burden on users instead of clean patch ;)

> I tried to find out who and why this got added, but this exists even before
> git history...
>

Same for my searches :(

So... there ain't a way to provide an improved patch that wouldn't
change anything but for tested BIOS versions (btw, mine is :
BIOS Information
        Vendor: Award Software, Inc.
        Version: ASUS P4B266 ACPI BIOS Revision 1010
        Release Date: 08/06/2002
) ?

That would be sad if the current blacklisting wasn't able to do such
checks on versions :(

Anyway, I suppose I will follow your advice and try and report people of
the acpi=force as I already started to do in
http://www.olivierberger.com/weblog/index.php?post/2009/03/28/Proper-power-management-on-Asus-P4B266-mainboard

Thanks for your helps.

Best regards,

-- 
Olivier BERGER 
(OpenPGP: 1024D/B4C5F37F)
http://www.olivierberger.com/weblog/
