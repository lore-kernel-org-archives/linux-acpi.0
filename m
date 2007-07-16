From: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH][BUTTON] remove procfs-interface
Date: Mon, 16 Jul 2007 09:35:33 +0200
Message-ID: <20070716073533.GA23083@suse.de>
References: <4695F726.7030203@nachtwindheim.de> <823A93EED437D048963A3697DB0E35DE7314AB@pdsmsx414.ccr.corp.intel.com> <a781481a0707121207o3497edbye9f89c9f2589f3e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757264AbXGPHgP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a781481a0707121207o3497edbye9f89c9f2589f3e5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Satyam Sharma <satyam.sharma@gmail.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Henne <henne@nachtwindheim.de>, Arjan van de Ven <arjan@infradead.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 13, 2007 at 12:37:07AM +0530, Satyam Sharma wrote:
> On 7/12/07, Zhang, Rui <rui.zhang@intel.com> wrote:
> >Well, the ACPI sysfs conversion is not finished yet
> >[...]
> >I'm not sure if the button sysfs I/F is already finished.
> >We'd better make a double check. :)
>=20
> Ok, this sounds reasonable.
>=20
> >and some user space tools still use the ACPI procfs.
>=20
> But this does *not*, IMHO. It quite defeats the whole concept of
> feature-removal-schedule.txt. I think that file exists precisely
> because we cannot gratuitously break userspace interfaces just
> like that, but when something gets put up there with a removal date
> that is a good one year in the future, and userspace tools _still_
> continue to use it ... then, I suspect something's seriously wrong.

Holy sh*t. There is not even a functional replacement ready, but still
everybody wants to remove /proc/acpi. (Maybe the replacement started
to work recently, i have not looked into this area for the last months.
This does not change my pint, though).
This is not going to work.
IMNSHO, we need the new interface available and usable for quite some t=
ime
(i'd say for over one year), and then we can start to phase out the old
interface.
Starting with removing /proc/acpi is not the correct ordering of action=
s.
=20
> Either the feature-removal-schedule.txt file has become something
> that users don't even bother checking, or else, they _know_ that
> even if they don't bother keeping up with the pace in kernel-land,
> that interface still won't go away (because they're still using it!).

Or they look at the feature-removal document, find out that there is
no replacement available and conclude "the writers of this document
must have been on crack, or this document is unmaintained". I cannot
disagree with them.
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
