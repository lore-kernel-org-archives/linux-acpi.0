From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level =?utf-8?q?suspend=09and_hibernation_callbacks?= (rev. 2)
Date: Tue, 25 Mar 2008 14:06:15 +0100
Message-ID: <200803251406.16741.rjw@sisk.pl>
References: <200803210101.04706.rjw@sisk.pl> <1206058863.16475.165.camel@johannes.berg> <200803251049.27696.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754072AbYCYNHH@vger.kernel.org>
In-Reply-To: <200803251049.27696.oliver@neukum.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> Am Freitag, 21. M=C3=A4rz 2008 01:21:03 schrieb Johannes Berg:
> > > + * All of the above callbacks, except for @complete(), return er=
ror codes.
> > > + * However, the error codes returned by the resume operations, @=
resume(),
> > > + * @thaw(), and @restore(), are only printed in the system logs,=
 since the PM
> > > + * core cannot do anything else about them.
> >=20
> > Why bother and not just make them return void, the error printing c=
an
> > most likely be done much much better in the callback since that pos=
sibly
> > has information on why it failed.
>=20
> A device that cannot wake up is unusable. Shouldn't the pm core disco=
nnect()
> such a device?

Well, if ->resume() returns an error, the driver already knows there's =
a
problem and it can act upon that, at least in principle.

However, the PM core probably shouldn't try to resume the children of a=
 failing
device.  Also, if ->resume_noirq() fails, it probably is not a good ide=
a to
call ->resume() and ->complete() for the same device and for it's child=
ren.

Thanks,
Rafael
