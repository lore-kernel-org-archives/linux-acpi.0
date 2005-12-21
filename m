From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Subject: Re: [ACPI] Re: asus_acpi still broken on Samsung P30/P35
Date: Wed, 21 Dec 2005 20:22:54 +0100
Message-ID: <43A9AB8E.7010802@gmx.net>
References: <200512211611.51977.mail@hboeck.de> <Pine.LNX.4.64.0512211035370.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751188AbVLUTXI@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0512211035370.4827@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: =?ISO-8859-15?Q?Hanno_B=F6ck?= <mail@hboeck.de>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Karol Kozimor <sziwan@hell.org.pl>, Christian Aichinger <Greek0@gmx.net>
List-Id: linux-acpi@vger.kernel.org

Linus Torvalds schrieb:
>=20
> On Wed, 21 Dec 2005, Hanno B=C3=B6ck wrote:
>=20
>>This is not "some minor issue", this completely breaks the usage of c=
urrent=20
>>vanilla-kernels on certain Hardware. Can please, please, please anyon=
e in the=20
>>position to do this take care that this patch get's accepted before 2=
=2E6.15?
>>
>>The patch is available inside mm-sources or here:
>>http://www.int21.de/samsung/p30-2.6.14.diff
>>
>>If I should send it to anyone else or if there's anything I can do to=
 help=20
>>fixing this, I'm glad to help.
>=20
>=20
> Last I saw this patch, I wrote this reply (the patch above is still=20
> broken). Nobody ever came back to me on it.
> [...]

I've been busy trying to gather all the different DSDTs to compare
them and find out if the logic can be simplified. Will try to come
up with a patch addressing all your and Andrew's concerns until friday.

Regards,
Carl-Daniel
