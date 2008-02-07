From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] Override DSDT via initramfs
Date: Wed, 6 Feb 2008 20:07:38 -0500
Message-ID: <200802062007.38885.lenb@kernel.org>
References: <4798E2A5.6020804@users.sf.net> <200802061915.25049.lenb@kernel.org> <47AA4F9D.7010601@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58931 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757701AbYBGBIg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2008 20:08:36 -0500
In-Reply-To: <47AA4F9D.7010601@tremplin-utc.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?=C3=89ric_Piel?= <Eric.Piel@tremplin-utc.net>
Cc: trenn@suse.de, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

On Wednesday 06 February 2008 19:23, =C3=89ric Piel wrote:
> 07/02/08 01:15, Len Brown wrote/a =C3=A9crit:
> > On Sunday 03 February 2008 12:28, =C3=89ric Piel wrote:
> >> Hello,
> >>
> >> Here are three patches to implement the override of DSDT via initr=
amfs.=20
> >> I haven't included the feature for overriding the SSDTs as it's se=
ems=20
> >> it's still a bit controversial, and anyway for now there is very l=
ittle=20
> >> need for it. It should be fairly trivial to add it later if need a=
rises.
> >>
> >> The patches are against 2.6.24-git-du-jour, and they have been=20
> >> boot-tested on my laptop.
> >=20
> > Thanks Eric,
> > I'll take Thomas, Carlos and my comments and my comments
> > and try to address them w/ a follow-up patch tonight.
> >=20
> > -Len
> Ah, Great! Just for info, I had started answering the comments from T=
homas and Carlos. Here is my proposed version as description for Kconfi=
g:
>=20
> 	  With this feature you will be able to provide a customized DSDT by
> 	  adding it to your initramfs. Overriding of the DSDT is mainly thou=
ght
> 	  for developing/testing purposes! If you have problems with ACPI on
> 	  your machine and you have fixed it up by modifying the DSDT, do no=
t
> 	  override the DSDT as a long term solution.  E.g. if you add new
> 	  memory to your machine, the modified DSDT will not work (BIOS woul=
d
> 	  generate a slightly adjusted one).  Always report bugs in a DSDT t=
o
> 	  your computer vendor and to bugzilla.kernel.org (assigned to the A=
CPI
> 	  component).
>=20
> 	  In case your mkinitrd tool does not support this feature, a script=
 is
> 	  provided in the documentation. For more details on this option see
> 	  <file:Documentation/dsdt-initrd.txt>.
> 	 =20
> 	  If you feel like tinkering with the DSDT or might have to test a
> 	  corrected DSDT one day select this option. It is safe to say Y her=
e.
>=20
> You can use it as inspiration ;-) More over, I was thinking of adding=
 a note in dsdt-initrd.txt like this:
>=20
> Do note that
> the format of the table included in the initramfs is binary (iasl -ta=
), while
> if you include the DSDT straight inside the kernel, the format is hex=
adecimal
> (iasl -tc).

i think we can add that to the detailed how-to, which I'd=20
rather have on a web page with a pointer to the latest tools etc.
(yes, i hold the pen on the web page too:-)

let me send those patches now before dinner break...

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
