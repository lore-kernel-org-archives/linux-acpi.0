From: Luca Capello <luca@pca.it>
Subject: Re: Critical temp shutdowns on ThinkPad X60 1706-GMG
Date: Thu, 31 Jul 2008 15:04:03 +0200
Message-ID: <871w1aurwc.fsf@gismo.pca.it>
References: <200807301556.01815.trenn@suse.de>
 <20080730175227.GA13850@khazad-dum.debian.net>
 <87zlnyv14h.fsf_-_@gismo.pca.it> <200807311439.46393.trenn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
 protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from victor.unige.ch ([129.194.9.224]:46291 "EHLO victor.unige.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751656AbYGaNEK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 09:04:10 -0400
Received: from gismo.pca.it ([129.194.56.110])
 by victor.unige.ch (Sun Java(tm) System Messaging Server 6.3-5.02 (built Oct
 12 2007; 32bit)) with ESMTPSA id <0K4V00L19GAWNO00@victor.unige.ch> for
 linux-acpi@vger.kernel.org; Thu, 31 Jul 2008 15:04:09 +0200 (MEST)
In-reply-to: <200807311439.46393.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ak@linux.intel.com, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, lenb@kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Hi Thomas!

On Thu, 31 Jul 2008 14:39:45 +0200, Thomas Renninger wrote:
> On Thursday 31 July 2008 11:44:46 Luca Capello wrote:
>> If anyone has any specific suggestion, starting from next Wednesday, Aug
>> 6th, I can perform tests on a clean Debian sid-amd64 (if needed, I can
>> install an i386) and with vanilla kernels.
>
> You should first try to reproduce this on a mainline kernel.

I know that, and I wrote the above sentence to exactly explain why I'm
not going to give other news on this subject before at least one week.

> Is the thermal driver loaded?

Yes.

> If it's a Debian specific patch..., I don't know how to bisect them
> but you should try to find out which one is the offender and post on a
> debian site.

I know how to deal with Debian [1] ;-)

> If this is a mainline problem you might want to revert all
> _OSI(Windows) from OS. Or better only return true for _OSI("Windows
> 2006").

In this case, I'll need help.  However, since I know now how to
reproduce the problem, I also have a method to test the different
solutions.

> If you have a mainline kernel problem, watch the list, maybe this
> patch will help you.

I read the list, thanks.  I was so surprised that no one reported this
issue before and I've already planned to deal with it during
DebCamp8/DebConf8 (starting on Sunday, Aug 3rd [2]).

Thx, bye,
Gismo / Luca

Footnotes:=20
[1] http://wiki.debian.org/LucaCapello
[2] http://debconf8.debconf.org

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iJwEAQECAAYFAkiRuEMACgkQZwOMsWhEDTMWDgP+OjtYx5a/1Y4YQPekMl8wG3AL
KcDnqHmmDXrW+uMFfX/iyOD+YuWvwBqL47eNYy87LUm27XvtkqJq5bY+pTtXzzEH
SoM9al5ns2Ey+aYfDnqPjh0XEH6ZKTywEmpXrKDLCKrYKSs3RUkFOKte4hCKNVc0
zKsEzZWPwZ+9oAawEyQ=
=MBk9
-----END PGP SIGNATURE-----
--=-=-=--
