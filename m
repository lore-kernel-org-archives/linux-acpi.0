From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Another report of EC behaviour changes since 2.6.24
Date: Wed, 3 Sep 2008 09:06:27 -0300
Message-ID: <20080903120627.GA639@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56735 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755079AbYICMGd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2008 08:06:33 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>

Here's another report of an observed change in EC behaviour since 2.6.2=
4.

I don't know if it the warnings are new (i.e. the problem was already
there), or if it is caused by regressions due to the changes in EC hand=
ling
since 2.6.24.

Would you like it appended to some bugzilla report? Which?

BTW: the problem is not just cosmetic, it is linked with bad data recei=
ved
from the EC (0xFF in two consecutive registers reads, instead of the
expected data).  Whether it *caused* the bad data to be read, or was ca=
used
by something that also caused that bad data to be read, I don't know.

----- Forwarded message from Toralf F=F6rster <toralf.foerster@gmx.de> =
-----
At Tuesday 02 September 2008 23:04:06 Henrique de Moraes Holschuh wrote=
 :
> On Tue, 02 Sep 2008, Toralf F=F6rster wrote:
> > Sep  1 21:25:42 n22 ACPI: EC: missing OBF confirmation, don't expec=
t it
> > any longer.
> > Sep  1 21:25:42 n22 ACPI: EC: missing write data confirmation, don'=
t
> > expect it any longer.
>
> It shouldn't be doing this.  Did you ever get any of those in previou=
s
> kernels?

=46rom
$>zcat /var/log/messages* | grep -e 'Linux version' -e 'EC: missing' | =
sort

it seems to start with straight vanilla kernel 2.6.25.14, happens in *.=
15 and=20
*.16 too, however the previous kernel 2.6.24-gentoo-r8 didn't log any l=
ine of=20
this issue.

----- End forwarded message -----

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
