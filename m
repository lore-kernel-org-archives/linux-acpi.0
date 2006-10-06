From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Cast removal
Date: Fri, 06 Oct 2006 22:39:13 +0200
Message-ID: <1160167153.3000.118.camel@laptopd505.fenrus.org>
References: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com>
	 <20061006143555.GC14186@rhun.haifa.ibm.com>
	 <Pine.LNX.4.61.0610062211220.30417@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:721 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932612AbWJFUj2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Oct 2006 16:39:28 -0400
In-Reply-To: <Pine.LNX.4.61.0610062211220.30417@yvahk01.tjqt.qr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, "Moore, Robert" <robert.moore@intel.com>, Andrew Morton <akpm@osdl.org>, Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI List <linux-acpi@vger.kernel.org>

On Fri, 2006-10-06 at 22:18 +0200, Jan Engelhardt wrote:
> >> -	(void) kmem_cache_destroy(cache);
> >> +	kmem_cache_destroy(cache);
> >>=20
> >> I believe that the point of the (void) is to prevent lint from
> >> squawking, and perhaps some picky ANSI-C compilers. What is the ov=
erall
> >> Linux policy on this?
> >
> >IMHO there's another reason to do this which is much more relevant: =
it
> >tells the reader that whoever wrote it knows that it returns a value
> >and ignores it on purpose.
>=20
> And GCC does not care about that, i.e. it still prints foritfy warnin=
gs,=20
> as in:
>=20
> $ svn co https://svn.sourceforge.net/svnroot/ttyrpld/trunk a && cd a
> $ make user/rpld.o EXT_CFLAGS=3D"-D_FORTIFY_SOURCE=3D2"
> user/rpld.c:425: warning: ignoring return value of =E2=80=98write=E2=80=
=99, declared=20
> with attribute warn_unused_result

this is by design. __must_check means you MUST do it.


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
