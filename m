From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [PATCH 0/3] Override DSDT via initramfs
Date: Mon, 04 Feb 2008 23:57:34 +0100
Message-ID: <47A7985E.6080401@tremplin-utc.net>
References: <4798E2A5.6020804@users.sf.net>	 <200801311417.57469.lenb@kernel.org>	 <1201859637.14573.41.camel@queen.suse.de>	 <200802012336.10687.lenb@kernel.org>  <47A5F9AE.7020509@tremplin-utc.net> <1202147606.14573.187.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:18518 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330AbYBDW5l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Feb 2008 17:57:41 -0500
In-Reply-To: <1202147606.14573.187.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

04/02/08 18:53, Thomas Renninger wrote/a =C3=A9crit:
> On Sun, 2008-02-03 at 18:28 +0100, =C3=89ric Piel wrote:
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
> I have some problems with the diff format.
> Is this a git diff, incompatible with normal patch/diff tools?
> Hmm, I tried git-apply --check -p1, but it also didn't work for me.
>=20
No, git is not to blame. It's might fault, I forgot to deactivate=20
"format=3Dflowed" in Thunderbird (well, I thought using an external edi=
tor
was automatically avoiding the problem). So basically, you have to remo=
ve
one space on each line starting with two spaces... or wait a little bit=
,=20
I'll resend the patches right now!

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
