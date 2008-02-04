From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/3] Override DSDT via initramfs
Date: Mon, 04 Feb 2008 18:53:26 +0100
Message-ID: <1202147606.14573.187.camel@queen.suse.de>
References: <4798E2A5.6020804@users.sf.net>
	 <200801311417.57469.lenb@kernel.org>
	 <1201859637.14573.41.camel@queen.suse.de>
	 <200802012336.10687.lenb@kernel.org>  <47A5F9AE.7020509@tremplin-utc.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:38462 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbYBDRx2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2008 12:53:28 -0500
In-Reply-To: <47A5F9AE.7020509@tremplin-utc.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

On Sun, 2008-02-03 at 18:28 +0100, =C3=89ric Piel wrote:
> Hello,
>=20
> Here are three patches to implement the override of DSDT via initramf=
s.=20
> I haven't included the feature for overriding the SSDTs as it's seems=
=20
> it's still a bit controversial, and anyway for now there is very litt=
le=20
> need for it. It should be fairly trivial to add it later if need aris=
es.
>=20
> The patches are against 2.6.24-git-du-jour, and they have been=20
> boot-tested on my laptop.

I have some problems with the diff format.
Is this a git diff, incompatible with normal patch/diff tools?
Hmm, I tried git-apply --check -p1, but it also didn't work for me.

Thanks,
=20
   Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
