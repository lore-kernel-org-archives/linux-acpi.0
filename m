From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: kernel error : 'find /proc/ -type f | xargs -n 1 head -c 10
 >/dev/null'
Date: Thu, 28 Jan 2010 09:39:27 +0800
Message-ID: <1264642767.22448.633.camel@rzhang1-desktop>
References: <201001212017.00160.toralf.foerster@gmx.de>
	 <20100121203535.GA5133@x200> <201001212219.03718.toralf.foerster@gmx.de>
	 <alpine.LRH.2.00.1001261416430.15694@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:27422 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291Ab0A1BlO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Jan 2010 20:41:14 -0500
In-Reply-To: <alpine.LRH.2.00.1001261416430.15694@twin.jikos.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, Alexey Dobriyan <adobriyan@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2010-01-26 at 21:17 +0800, Jiri Kosina wrote:
> [ adding relevant CCs ]
>=20
> On Thu, 21 Jan 2010, Toralf F=C3=B6rster wrote:
>=20
> > Alexey Dobriyan wrote at 21:35:35
> > > On Thu, Jan 21, 2010 at 08:16:59PM +0100, Toralf F=C3=B6rster wro=
te:
> > > > I was inspired by http://article.gmane.org/gmane.linux.kernel/9=
41115 .
> > > >
> > > > Running the command (se subject) as a normal user at a 2.6.32.4=
 kernel
> > > > gives this in /var/log/messages:
> > > >
> > > > head: page allocation failure. order:9, mode:0xd0
> > > > Pid: 2324, comm: head Not tainted 2.6.32.4 #1
> > > > Call Trace:
> > > > [<c106e2cc>] ? __alloc_pages_nodemask+0x4bc/0x5a0
> > > > [<c108cf5a>] ? cache_alloc_refill+0x2ba/0x510
> > > > [<c108d299>] ? __kmalloc+0xe9/0xf0
> > > > [<c10aa755>] ? seq_read+0x195/0x370
> > >=20
> > > Please, find out which file is causing this, if it's reproducible=
=2E
> > >=20
> > I reproduced the msg :
> > "ACPI: Please implement acpi_video_bus_ROM_seq_show" by :
> > by
> > $> head -c 10 /proc/acpi/video/VID/info
> >=20
this is just a KERN_INFO message that suggests the
acpi_video_bus_ROM_seq_show method is not actually implemented right
now.

I don't think it has anything to do with the trace. :)

thanks,
rui

> > After suspend to disk and wakeup however the file /proc/acpi/video/=
VID/ROM was=20
> > the culprit.
> >=20
> > The trace however I can't reproduce until now.
> >=20
> >=20
> >=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
