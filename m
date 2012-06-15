From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] ACPI, APEI: Fixup common access width firmware bug
Date: Fri, 15 Jun 2012 13:40:34 +0200
Message-ID: <1339760434.4288.20.camel@amber.site>
References: <1339490608.21507.5.camel@amber.site>
	 <20120614010931.GA7378@us.ibm.com> <1339662911.4378.22.camel@amber.site>
	 <20120614170752.GB1999@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40642 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755628Ab2FOLku (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Jun 2012 07:40:50 -0400
In-Reply-To: <20120614170752.GB1999@us.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, hui.xiao@linux.intel.com

Hi Gary,

Le jeudi 14 juin 2012 =C3=A0 10:07 -0700, Gary Hade a =C3=A9crit :
> On Thu, Jun 14, 2012 at 10:35:11AM +0200, Jean Delvare wrote:
> > I see it as a firmware bug, nothing else
>=20
> That was my strong feeling but since the number of sightings
> seems to be on the increase, I thought it might be good to talk
> about whether our interpretation is actually correct.

It's always good to ensure we got things right, sure. WRT to the number
of faulty systems, I wouldn't jump to any conclusion. It is sufficient
to have a bug in the reference BIOS code in order to see the same bug
spread across boards and vendors all around.

> > (although I am still waiting
> > for Asus to reply on this.) And if it really isn't a bug, I can onl=
y
> > read it as "we have a 32-bit register that can only be read 8-bit a=
t a
> > time so please issue 4 8-bit reads and build up a 32-bit value out =
of
> > these." And certainly not as "don't touch the upper 24-bits."
>=20
> It will definitely be interesting to see what you hear from Asus.

If I ever hear something... No news yet :(

> Multiple reads or writes to access all the bits in a register
> does _not_ sound like a reasonable interpretation of the ACPI
> spec to me.

Well, I can imagine that some hardware has (or has had) such
limitations, and the ACPI spec authors may have wanted to play it safe
and make it possible to describe this case. I didn't mean that I expect
it to be the case for my Asus board - I still believe it is a simple
BIOS bug here.


--=20
Jean Delvare
Suse L3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
