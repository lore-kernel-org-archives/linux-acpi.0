From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [regression] linux-3.14.0-rc5-.. kernel does not switch power off
Date: Sun, 09 Mar 2014 18:15:38 +0100
Message-ID: <34025658.DfioqOCCn3@vostro.rjw.lan>
References: <CADDKRnCTBiGC2fkd1Utp7BY7vjORcHh4O9GgqfMP7iDfFkNKuw@mail.gmail.com> <4129487.hPye7CfaJv@vostro.rjw.lan> <4824481.V0Gqxh5Nec@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55029 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751207AbaCIRAV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Mar 2014 13:00:21 -0400
In-Reply-To: <4824481.V0Gqxh5Nec@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sunday, March 09, 2014 05:58:59 PM Rafael J. Wysocki wrote:
> On Sunday, March 09, 2014 05:55:28 PM Rafael J. Wysocki wrote:
> > On Sunday, March 09, 2014 05:12:56 PM J=C3=B6rg Otte wrote:
> > > On shutdown power is not switched off. The harddisk is already do=
wn.
> > > Reboot is working.
> > >=20
> > > Last known good kernel is: 3.14.0-rc5-00265-gb01d4e6
> > > First known bad kernel is: 3.14.0-rc5-00287-gca62eec
> >=20
> > Can you please tell me which commits those two kernels correspond t=
o?
>=20
> And please post a boot log from the failing one.

Never mind, I know what the problem is, commit 3130497f5bab (ACPI / sle=
ep:
pm_power_off needs more sanity checks to be installed) has to be revert=
ed.

Sorry about the breakage and I'll send a revert patch shortly.

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
