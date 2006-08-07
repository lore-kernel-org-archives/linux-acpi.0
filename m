From: Eric Piel <Eric.Piel@tremplin-utc.net>
Subject: Re: Options depending on STANDALONE
Date: Mon, 07 Aug 2006 20:46:31 +0200
Message-ID: <44D78A87.3020204@tremplin-utc.net>
References: <CFF307C98FEABE47A452B27C06B85BB601260CC7@hdsmsx411.amr.corp.intel.com> <1154972011.4302.712.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:41156 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S932228AbWHGTOY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Aug 2006 15:14:24 -0400
In-Reply-To: <1154972011.4302.712.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "Brown, Len" <len.brown@intel.com>, Greg KH <greg@kroah.com>, Adrian Bunk <bunk@stusta.de>, Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>, Arjan van de Ven <arjan@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>, v4l-dvb-maintainer@linuxtv.org, linux-acpi@vger.kernel.org

08/07/2006 07:33 PM, Thomas Renninger wrote/a =C3=A9crit:
>=20
> There are three reasons for the initrd patch (last one also applies f=
or
> the compile in functionality):
Hi, I just happen to be the maintainer "this initrd patch" ;-) I agree=20
with you Thomas. IMHO, this patch is really useful in our "not so=20
perfect" world. Few more comments below:

>=20
> 1)
> There might be "BIOS bugs" that will never get fixed:
> https://bugzilla.novell.com/show_bug.cgi?id=3D160671
> (Because it's an obvious BIOS bug, "compatibility" fixing it could ma=
ke
> things worse).
This is really feature #1, PC manufacturers come to sometimes extremely=
=20
ugly things when they code their ACPI tables. You can find lots of BIOS=
=20
containing in their ACPI tables tests like "do this if OS name is 13=20
letters long, and that if OS name is 11 letters long..." Obviously=20
Linux is most of the time not within those tests!

1.5) Feature adding. Some (crazy?) people are working on new=20
implementation of their ACPI table to add features (cf the "Smart=20
Battery System for Linux" project).

In those two cases, you really can't expect every user to recompile it'=
s=20
Linux kernel to get an new DSDT table :-)

> 2)
> There might be "ACPICA/kernel bugs" that take a while until they get
> fixed:
>=20
> This happens often. There comes out a new machine, using AML in a
> slightly other way, we need to fix it in kernel/ACPICA. Until the pat=
ch
> appears mainline may take a month or two. Until the distro of your
> choice that makes use of the fix comes out might take half a year or
> more...
> And backporting ACPICA fixes to older kernels is currently not possib=
le
> as ACPICA patches appear in a big bunch of some thousand lines patche=
s.
> But this hopefully changes soon.
>=20
> In my mind come:
> - alias broken in certain cases
>    https://bugziall.novell.com/show_bug.cgi?id=3D113099
> - recon amount of elements in packages
>    https://bugzilla.novell.com/show_bug.cgi?id=3D189488
> - wrong offsets at Field and Operation Region declarations
>    -> should be compatible for quite a while now
> - ...
Agree, although I  believe of this as more an excuse than a reason.=20
Linux is still full of bugs, lots of which cannot be fixed by ACPI tabl=
e=20
swapping anyway...

> 3)
> Debugging.
> This is why at least compile in or via initrd must be provided in
> mainline kernel IMHO. Intel people themselves ask the bug reporter to
> override ACPI tables with a patched table to debug the system.
> Do you really think ripping out all overriding functionality from the
> kernel is a good idea?
Well, I think even Len agree with this usage :-)

All in all, I'm really _not_ asking for inclusion of the patch in the=20
main tree. Just asking you not to think too much bad of the distros=20
which use this patch ;-) (IIRC, at least Mandriva and Ubuntu include it=
=20
in addition to SuSE)

See you,
Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
