From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] Override DSDT via initramfs
Date: Wed, 6 Feb 2008 19:15:24 -0500
Message-ID: <200802061915.25049.lenb@kernel.org>
References: <4798E2A5.6020804@users.sf.net> <200802012336.10687.lenb@kernel.org> <47A5F9AE.7020509@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42478 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763419AbYBGAQZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2008 19:16:25 -0500
In-Reply-To: <47A5F9AE.7020509@tremplin-utc.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?=C3=89ric_Piel?= <Eric.Piel@tremplin-utc.net>
Cc: trenn@suse.de, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

On Sunday 03 February 2008 12:28, =C3=89ric Piel wrote:
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

Thanks Eric,
I'll take Thomas, Carlos and my comments and my comments
and try to address them w/ a follow-up patch tonight.

-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
