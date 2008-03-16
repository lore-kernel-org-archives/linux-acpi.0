From: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [2.6.25-rc5-mm1] BUG: spinlock bad magic early during boot
Date: Sun, 16 Mar 2008 01:15:36 +0100
Message-ID: <47DC66A8.1020905@tremplin-utc.net>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>  <47D86D43.2060108@imap.cc> <1205441216.4971.65.camel@nimitz.home.sr71.net>  <47D9C853.3040701@imap.cc> <1205517802.12763.18.camel@nimitz.home.sr71.net>  <1205525184.12763.32.camel@nimitz.home.sr71.net>  <47DAE55C.3080506@tremplin-utc.net>  <1205530551.8167.20.camel@nimitz.home.sr71.net>  <47DB013D.3060102@tremplin-utc.net> <1205537395.8167.31.camel@nimitz.home.sr71.net> <47DBC578.7050101@imap.cc> <alpine.LFD.1.00.0803151212180.3020@woody.linux-foundation.org> <47DC26BC.7060502@tremplin-utc.net> <alpine.LFD.1.00.0803151315250.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:23916 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbYCPAPn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Mar 2008 20:15:43 -0400
In-Reply-To: <alpine.LFD.1.00.0803151315250.3020@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tilman Schmidt <tilman@imap.cc>, Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>, Christoph Hellwig <hch@infradead.org>, Markus Gaugusch <dsdt@gaugusch.at>, linux-acpi@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Arjan van de Ven <arjanv@redhat.com>

15/03/08 21:19, Linus Torvalds wrote/a =E9crit:
> What's the problem with just loading a new DSDT later? Potentially as=
 in=20
> *much* later: including when user-space is all up-and-running?=20
>=20
:
> So what's the reason for pushing for this insanely-early workaround i=
n the=20
> first place, instead of letting user-space do something like
>=20
> 	cat my-dsdt-image > /proc/sys/acpi/DSDT
>=20
> or whatever at runtime?
Yeah, or probably more something like this nowadays ;-)
	cat my-dsdt-image > /sys/firmware/acpi/tables/DSDT

As I said in my previous email, I'm already convinced that late-overrid=
e
of ACPI table approach would be very interesting to investigate.
However, this cannot be taken lightly. A _lot_ of places in the kernel
depend on the ACPI and nothing has ever been done in the direction of
dynamic modification of the APCI tables. The implementation is likely t=
o
be much bigger than the current 100 lines of patch.

That said, it should be possible to draw some assumptions without
restraining much the functionality. Such as:
 * every object present in the original table is still present is the
new table
 * they keep the same name

Len, do you think it would be feasible? How do you think the
implementation could be done?

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
