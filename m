From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [v3.20]: Missing /sys/class/ACAD directory OR Cannot release Mutex
Date: Tue, 24 Feb 2015 00:24:16 +0100
Message-ID: <1643186.zN49pcFPny@vostro.rjw.lan>
References: <CADDKRnDO7LAr5bg-5TJ-2=Va3kBw-cWqDvWoL3omWVJHUUd7tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56350 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752120AbbBWXAy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Feb 2015 18:00:54 -0500
In-Reply-To: <CADDKRnDO7LAr5bg-5TJ-2=Va3kBw-cWqDvWoL3omWVJHUUd7tA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sunday, February 22, 2015 01:33:09 PM J=C3=B6rg Otte wrote:
> Starting with kernel 3.19.0-05184-g18320f2, I often find my notebook
> running with 'powersave' policy even if it is on AC.
>=20
> It turned out that /sys/class/ACAD directory is missing and in the
> logs I see:
>=20
> ACPI Error: Cannot release Mutex [MUT0], not acquired (20150204/exmut=
ex-376)
> ACPI Error: Method parse/execution failed [\_SB_.ACAD._PSR] (Node
> ffff880216028d48), AE_AML_MUTEX_NOT_ACQUIRED (20150204/psparse-536)
> ACPI Exception: AE_AML_MUTEX_NOT_ACQUIRED, Error reading AC Adapter
> state (20150204/ac-131)
>=20
> At the last 25 startups since 3.19.0-05184-g18320f2 it occured 13 tim=
es.
>=20
> It does not occur with kernels older than 3.19.0-05184-g18320f2.

Which mainline commit is that?

The only changes in 4.0-rc1 that can affect that are the ACPI EC update=
s IIRC.

Is there a chance to try the acpi-ec branch from linux-pm.git and see i=
f the
problem is there?

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
