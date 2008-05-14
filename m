From: Len Brown <lenb@kernel.org>
Subject: Re: About p4-clockmod breakage/removal
Date: Tue, 13 May 2008 20:48:00 -0400
Message-ID: <200805132048.00653.lenb@kernel.org>
References: <48246C3E.7010608@ceibo.fiec.espol.edu.ec>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35270 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756807AbYENAyd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 May 2008 20:54:33 -0400
In-Reply-To: <48246C3E.7010608@ceibo.fiec.espol.edu.ec>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: cpufreq@lists.linux.org.uk
Cc: Alex =?iso-8859-1?q?Villac=ED=ADs_Lasso?= <avillaci@ceibo.fiec.espol.edu.ec>, linux-acpi@vger.kernel.org

On Friday 09 May 2008, Alex Villac=ED=ADs Lasso wrote:
> In a somewhat old computer I use at home, I have a Pentium 4 CPU runn=
ing=20
> at 1.7GHz. On this computer, acpi-cpufreq does not work (modprobe fai=
ls=20
> with -ENODEV), only p4-clockmod. Lately this means I have to compile =
my=20
> own kernel to get speed throttling on my computer.
>=20
> Recently, patch ed9cbcd40004904dbe61ccc16d6106a7de38c998 (Revert=20
> "speedstep-lib.c: fix frequency multiplier for Pentium4 models 0&1")=20
> broke clock speed reporting. It now reports I have a max speed of 13.=
80=20
> GHz instead of 1.7GHz. I only wish my CPU were that fast... Reverting=
=20
> this patch fixes the problem for me. However, since I suscribed=20
> yesterday to this list, I see talk about removing p4-clockmod altoget=
her=20
> from the tree. Maybe my real problem is that acpi-cpufreq does not wo=
rk=20
> even though it should, but I have yet to find a way to make the modul=
e=20
> print the information that is supposed to be displayed through dprint=
k()=20
> messages. What else can I do to debug acpi-cpufreq on my machine?

Assuming this is a laptop with a batter,
I'd certainly be interested if you could run BLTK
and measure any benefit to p4-clockmod (I've never
been able to)

http://www.lesswatts.org/projects/bltk/

Re: acpi-cpufreq
Verify that you're running the latest BIOS,
and look in BIOS SETUP for any options related
to CPU power management, Speed Step, EIST, P-states etc,
and enable if present.

If that doesn't do it, then open a bug here
complaining that acpi-cpufreq doesn't load:

http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI

and attach the output from acpidump -- which will tell
us if the underlying BIOS support is present.
My guess is that it is not.

-Len

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
