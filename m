From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH] power/hibernate: Make passing hibernate offsets more
 friendly
Date: Mon, 26 Mar 2018 07:17:22 +0000
Message-ID: <b3e9a7ad5dfc4348a8b017110e8ba032@ausx13mpc120.AMER.DELL.COM>
References: <1520333620-22342-1-git-send-email-mario.limonciello@dell.com>
 <1854392.I8WPNng6r5@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1854392.I8WPNng6r5@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Monday, March 19, 2018 5:11 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: linux-acpi@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] power/hibernate: Make passing hibernate offsets more=
 friendly
>=20
> On Tuesday, March 6, 2018 11:53:40 AM CET Mario Limonciello wrote:
> > Currently the only way to specify a hibernate offset for a
> > swap file is on the kernel command line.
> >
> > Add a new /sys/power/disk_offset that lets userspace
> > specify the offset and disk to use when initiating a hibernate
> > cycle.
> >
> > Also split up the parsing routine to re-use the same code
> > for the /sys/power/resume and /sys/power/disk_offset parsing.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
>=20
> Well, IMO /sys/power/resume and /sys/power/disk_offset would be confusing=
ly
> similar after this patch.

Yeah they do function pretty similarly.

>=20
> I wonder if adding a resume_offset sysfs attr to simply allow the value o=
f
> resume offset alone to be passed to the kernel at run time (in addition t=
o
> the command line) would work?
>=20
> Thanks!

I guess what's your expected flow for how the disk gets selected though?  S=
hould
the kernel be "guessing" which disk to use?

Or should userspace be setting offset via /sys/power/resume_offset followed=
 by
disk in /sys/power/resume (which will show an error in syslog about no part=
ition
found)

If the latter, then I'd like to also modify the behavior to downgrade that =
missing
hibernate partition to debug instead too.
