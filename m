From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [PATCH 0/3] Override DSDT via initramfs
Date: Thu, 07 Feb 2008 01:23:57 +0100
Message-ID: <47AA4F9D.7010601@tremplin-utc.net>
References: <4798E2A5.6020804@users.sf.net> <200802012336.10687.lenb@kernel.org> <47A5F9AE.7020509@tremplin-utc.net> <200802061915.25049.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:13548 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765413AbYBGAYH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2008 19:24:07 -0500
In-Reply-To: <200802061915.25049.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: trenn@suse.de, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

07/02/08 01:15, Len Brown wrote/a =C3=A9crit:
> On Sunday 03 February 2008 12:28, =C3=89ric Piel wrote:
>> Hello,
>>
>> Here are three patches to implement the override of DSDT via initram=
fs.=20
>> I haven't included the feature for overriding the SSDTs as it's seem=
s=20
>> it's still a bit controversial, and anyway for now there is very lit=
tle=20
>> need for it. It should be fairly trivial to add it later if need ari=
ses.
>>
>> The patches are against 2.6.24-git-du-jour, and they have been=20
>> boot-tested on my laptop.
>=20
> Thanks Eric,
> I'll take Thomas, Carlos and my comments and my comments
> and try to address them w/ a follow-up patch tonight.
>=20
> -Len
Ah, Great! Just for info, I had started answering the comments from Tho=
mas and Carlos. Here is my proposed version as description for Kconfig:

	  With this feature you will be able to provide a customized DSDT by
	  adding it to your initramfs. Overriding of the DSDT is mainly though=
t
	  for developing/testing purposes! If you have problems with ACPI on
	  your machine and you have fixed it up by modifying the DSDT, do not
	  override the DSDT as a long term solution.  E.g. if you add new
	  memory to your machine, the modified DSDT will not work (BIOS would
	  generate a slightly adjusted one).  Always report bugs in a DSDT to
	  your computer vendor and to bugzilla.kernel.org (assigned to the ACP=
I
	  component).

	  In case your mkinitrd tool does not support this feature, a script i=
s
	  provided in the documentation. For more details on this option see
	  <file:Documentation/dsdt-initrd.txt>.
	 =20
	  If you feel like tinkering with the DSDT or might have to test a
	  corrected DSDT one day select this option. It is safe to say Y here.

You can use it as inspiration ;-) More over, I was thinking of adding a=
 note in dsdt-initrd.txt like this:

Do note that
the format of the table included in the initramfs is binary (iasl -ta),=
 while
if you include the DSDT straight inside the kernel, the format is hexad=
ecimal
(iasl -tc).

See you,
Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
