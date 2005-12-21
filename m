From: "Brown, Len" <len.brown@intel.com>
Subject: RE: asus_acpi still broken on Samsung P30/P35
Date: Wed, 21 Dec 2005 14:06:42 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300580F140@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751200AbVLUTHv@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, =?iso-8859-1?B?SGFubm8gQsO2Y2s=?= <mail@hboeck.de>, Karol Kozimor <sziwan@hell.org.pl>
Cc: Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Christian Aichinger <Greek0@gmx.net>
List-Id: linux-acpi@vger.kernel.org

Karol,
Do you have an update of your asus driver in the pipeline
that addresses this?

thanks,
-Len
=20

>-----Original Message-----
>From: Linus Torvalds [mailto:torvalds@osdl.org]=20
>Sent: Wednesday, December 21, 2005 1:37 PM
>To: Hanno B=C3=B6ck
>Cc: Andrew Morton; Brown, Len;=20
>acpi-devel@lists.sourceforge.net;=20
>linux-kernel@vger.kernel.org; Karol Kozimor; Christian Aichinger
>Subject: Re: asus_acpi still broken on Samsung P30/P35
>
>
>
>On Wed, 21 Dec 2005, Hanno B=C3=B6ck wrote:
>>=20
>> This is not "some minor issue", this completely breaks the=20
>usage of current=20
>> vanilla-kernels on certain Hardware. Can please, please,=20
>please anyone in the=20
>> position to do this take care that this patch get's accepted=20
>before 2.6.15?
>>=20
>> The patch is available inside mm-sources or here:
>> http://www.int21.de/samsung/p30-2.6.14.diff
>>=20
>> If I should send it to anyone else or if there's anything I=20
>can do to help=20
>> fixing this, I'm glad to help.
>
>Last I saw this patch, I wrote this reply (the patch above is still=20
>broken). Nobody ever came back to me on it.
>
>			Linus
>
>---
>Date: Tue, 13 Dec 2005 21:15:56 -0800 (PST)
>From: Linus Torvalds <torvalds@osdl.org>
>To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
>cc: Greg KH <greg@kroah.com>,=20
>    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,=20
>    stable@kernel.org, acpi-devel <acpi-devel@lists.sourceforge.net>
>Subject: Re: [PATCH] Fix oops in asus_acpi.c on Samsung P30/P35 Laptop=
s
>
>On Wed, 14 Dec 2005, Carl-Daniel Hailfinger wrote:
>>=20
>> The patch has been tested and verified, is shipped in the
>> SUSE 10.0 kernel and does not cause any regressions.
>
>I'd be _much_ happier if
>
> - the patch wasn't totally whitespace-damaged (your mailer seems=20
>   to not only remove spaces at the end of lines, it _also_=20
>adds them to=20
>   the beginning when there was another space there, as far as=20
>I can tell)
>
>   Being right "on average" thanks to having two different=20
>bugs does not a=20
>   good mailer make.
>
> - you were to separate out the oops-fixing code from the code=20
>that adds=20
>   handling for that (strange?) model type logic.
>
>   It seems that the _oops_ is because the later paths just=20
>assume that=20
>   it's a ACPI_TYPE_STRING and will dereference=20
>"model->string.pointer"=20
>   regardless of whether that is true or not. And you add a test for=20
>   ACPI_TYPE_INTEGER, however, you do _not_ fix the oops for any other=
=20
>   type, so the exact _same_ bug is still waiting to happen if=20
>there is=20
>   some other strange ACPI table entry some day.
>
>So I think the proper fix is to _first_ just do something like
>
>	if (model->type !=3D ACPI_TYPE_STRING)
>		goto unknown;
>
>which should fix the oops (no?), and then handling=20
>ACPI_TYPE_INTEGER above=20
>that as one case would be a separate patch.
>
>		Linus
>
