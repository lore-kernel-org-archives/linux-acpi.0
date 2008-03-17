From: Len Brown <lenb@kernel.org>
Subject: Re: [2.6.25-rc5-mm1] BUG: spinlock bad magic early during boot
Date: Mon, 17 Mar 2008 14:05:04 -0400
Message-ID: <200803171405.04808.lenb@kernel.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org> <alpine.LFD.1.00.0803151212180.3020@woody.linux-foundation.org> <47DC26BC.7060502@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34791 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755970AbYCQTxi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Mar 2008 15:53:38 -0400
In-Reply-To: <47DC26BC.7060502@tremplin-utc.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?=C3=89ric_Piel?= <Eric.Piel@tremplin-utc.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Tilman Schmidt <tilman@imap.cc>, Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>, Christoph Hellwig <hch@infradead.org>, Markus Gaugusch <dsdt@gaugusch.at>, linux-acpi@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Arjan van de Ven <arjanv@redhat.com>

On Saturday 15 March 2008, =C3=89ric Piel wrote:
> 15/03/08 20:21, Linus Torvalds wrote/a =C3=A9crit:
> >=20
> > I've reverted the whole thing. Or rather, since there were various =
small=20
> > fixup commits over time, and a simple revert doesn't really work, I=
 ended=20
> > up just removing the option and the code that was conditional on it=
 - that=20
> > way, if we really want to fight this out some time (after 2.6.25 is=
 out)=20
> > or some vendor wants to use a known-broken option anyway, there's a=
 simple=20
> > and fairly clean commit to revert the revert.
> >=20
> > It's commit 9a9e0d685553af76cb6ae2af93cca4913e7fcd47, see=20
> >=20
> > 	http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git=
;a=3Dcommitdiff;h=3D9a9e0d685553af76cb6ae2af93cca4913e7fcd47
> >=20
> > for details if you aren't a git person.

> It's a pity, I had just nearly finished a new approach. Instead of
> relying on populate_rootfs() and the filesystem infrastructure, the n=
ew
> approach directly finds the file in the initramfs. With
> unpack_to_rootfs(), it turned out to be rather straightforward. Attac=
hed
>  is a half-tested version of the patch (it boots and works but I have=
n't
> compiled without the option yet). Just in case you would like to chan=
ge
> your mind ;-)

I recommend that you make a new proposal for 2.6.26
that applies on top of Linus' top-of-tree and that we
include lkml in hashing it out rather than just linux-acpi.

thanks,
-Len
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
