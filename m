From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 4/4] ACPI: Battery: Add support for _BIX extended info
 method
Date: Mon, 15 Mar 2010 23:17:47 +0300
Message-ID: <4B9E95EB.8000604@suse.de>
References: <20091015103122.3853.34760.stgit@thinkpad> <20091015103144.3853.9717.stgit@thinkpad> <9b2b86520910160208l5bc6e20dkca79ae54505428ed@mail.gmail.com> <20091017154124.GA31182@khazad-dum.debian.net> <4B9D601A.3050708@gmail.com> <20100315113837.GA8296@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:50806 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936641Ab0COURt (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 15 Mar 2010 16:17:49 -0400
In-Reply-To: <20100315113837.GA8296@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, Len Brown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

Henrique de Moraes Holschuh =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> That just means the ACPI sysfs conversion on that area was not as goo=
d as it
> should have been.  It is hardly the only place where the sysfs ABI is=
 not
> well implemented, but that doesn't mean the breakage should remain, o=
r that
> it should be made worse.
> What is the technical case to returning invalid values for something =
that is
> not supported when you could return a proper error on open() instead =
(since
Power Class interface does not give me control over open() as far as I =
know.
> you're not going to do the Right Thing and not register that attribut=
e it in
> the first place)?  Not only the "-1" way wastes more system resources=
 (all
> clients have to do open+read+close), it also needs userspace to speci=
al case
> something, and that is always a Bad Idea for *many* reasons.
If you know how this could be done, please show the patch...

Thanks,
Alex.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
