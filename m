From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH RFC v2 0/3] add cpu physically hotplug driver
Date: Mon, 10 Jun 2013 08:36:07 +0800
Message-ID: <1370824567.21655.10.camel@liguang.fnst.cn.fujitsu.com>
References: <1370482835-764-1-git-send-email-lig.fnst@cn.fujitsu.com>
	 <5449620.11SBDUltzF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5449620.11SBDUltzF@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Hi, Rafael

=E5=9C=A8 2013-06-06=E5=9B=9B=E7=9A=84 13:00 +0200=EF=BC=8CRafael J. Wy=
socki=E5=86=99=E9=81=93=EF=BC=9A
> On Thursday, June 06, 2013 09:40:32 AM liguang wrote:
> > This patch-set try to support physically hot-plug/unplug
> > a cpu automatically, that is:
> > if you offline a cpu, it will automatically actually remove
> > a cpu, and if you hot-plug a cpu, then it will online this
> > cpu automatically.
>=20
> No and no.

Hmm... are you saying cpu online/offline designed to distinguish=20
with real cpu plug/unplug?
but, what the actual usage of online/offline?
forgive my foolish.

>=20
> Why do you need this?
>=20

e.g. for QEMU case, if hot-plug a cpu,
we have to online a cpu manually if there's=20
no user space support like udev to do it automatically.
and also, I think maybe online/offline should be naturally
integrated with real plug/unplug process of CPU.

>=20
>=20
> > so, offline is just like eject, but eject attribute seems not
> > available since recent kernel(can't figure out when), with
> > this driver, if allowed, it will trigger a eject cpu process.
> > and for automatically online, it was said there are objections,
> > don't know the reason, so, send this patch-set boldly.
> >=20
> > of course, this approach is for QEMU 's hotplug cpu emulation=20
> > only, but not limited, if someone like to explore ec space to
> > implment cpu hot-plug/unplug for real platform please
> > feel free to continue.
> >=20
> > Li Guang (3)
> > 	 drivers/platform/x86: add cpu physically hotplug driver
> > 	 ec: add ec space notifier
> > 	 cpu_physic_hotplug: register handler for ec space notifier
> >=20
> > drivers/acpi/ec.c                         | 32 ++++++++++++++++++++=
++++++++++++
> > drivers/platform/x86/Kconfig              |  8 ++++
> > drivers/platform/x86/Makefile             |  1 +
> > drivers/platform/x86/cpu_physic_hotplug.c | 90 ++++++++++++++++++++=
+++++++++
> > include/linux/acpi.h                      |  2 ++
> > 5 files changed, 130 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/platform/x86/cpu_physic_hotplug.c
