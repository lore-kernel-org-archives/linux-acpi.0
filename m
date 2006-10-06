From: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH] Cast removal
Date: Fri, 6 Oct 2006 22:30:42 +0200
Message-ID: <20061006203042.GK14186@rhun.haifa.ibm.com>
References: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com> <20061006143555.GC14186@rhun.haifa.ibm.com> <Pine.LNX.4.61.0610062211220.30417@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:21064 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932591AbWJFUbN
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Oct 2006 16:31:13 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610062211220.30417@yvahk01.tjqt.qr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Moore, Robert" <robert.moore@intel.com>, Andrew Morton <akpm@osdl.org>, Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI List <linux-acpi@vger.kernel.org>

On Fri, Oct 06, 2006 at 10:18:57PM +0200, Jan Engelhardt wrote:
=20
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

Sure, if an interface is decalred with warn_unused_result gcc should
warn, even if the caller casts it to void. But in the normal case,
casting the result of the function to void tells the reader that you
know that it returns something, and you don't care.

Cheers,
Muli


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
