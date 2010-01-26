From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: kernel error : 'find /proc/ -type f | xargs -n 1 head -c 10
 >/dev/null'
Date: Tue, 26 Jan 2010 14:17:32 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1001261416430.15694@twin.jikos.cz>
References: <201001212017.00160.toralf.foerster@gmx.de> <20100121203535.GA5133@x200> <201001212219.03718.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47580 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888Ab0AZNRe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jan 2010 08:17:34 -0500
In-Reply-To: <201001212219.03718.toralf.foerster@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-15?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>


[ adding relevant CCs ]

On Thu, 21 Jan 2010, Toralf F=F6rster wrote:

> Alexey Dobriyan wrote at 21:35:35
> > On Thu, Jan 21, 2010 at 08:16:59PM +0100, Toralf F=F6rster wrote:
> > > I was inspired by http://article.gmane.org/gmane.linux.kernel/941=
115 .
> > >
> > > Running the command (se subject) as a normal user at a 2.6.32.4 k=
ernel
> > > gives this in /var/log/messages:
> > >
> > > head: page allocation failure. order:9, mode:0xd0
> > > Pid: 2324, comm: head Not tainted 2.6.32.4 #1
> > > Call Trace:
> > > [<c106e2cc>] ? __alloc_pages_nodemask+0x4bc/0x5a0
> > > [<c108cf5a>] ? cache_alloc_refill+0x2ba/0x510
> > > [<c108d299>] ? __kmalloc+0xe9/0xf0
> > > [<c10aa755>] ? seq_read+0x195/0x370
> >=20
> > Please, find out which file is causing this, if it's reproducible.
> >=20
> I reproduced the msg :
> "ACPI: Please implement acpi_video_bus_ROM_seq_show" by :
> by
> $> head -c 10 /proc/acpi/video/VID/info
>=20
> After suspend to disk and wakeup however the file /proc/acpi/video/VI=
D/ROM was=20
> the culprit.
>=20
> The trace however I can't reproduce until now.
>=20
>=20
>=20

--=20
Jiri Kosina
SUSE Labs, Novell Inc.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
