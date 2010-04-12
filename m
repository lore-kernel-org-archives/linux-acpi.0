From: "Joey Lee" <jlee@novell.com>
Subject: Re: [RFC] Shutdown on thermal HOT event if no userspace tool
	 registered being able to do S4
Date: Sun, 11 Apr 2010 20:06:22 -0600
Message-ID: <4BC30CBE02000023000169A1@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kay.sievers@vrfy.org
Cc: rui.zhang@intel.com, hmacht@suse.de, rwysocki@suse.de, trenn@suse.de, linux-acpi@vger.kernel.org

Thank's for Kay's comment from udev side.

Hi Thomas,=20

=E6=96=BC =E5=9B=9B=EF=BC=8C2010-04-01 =E6=96=BC 15:40 +0200=EF=BC=8CKa=
y Sievers =E6=8F=90=E5=88=B0=EF=BC=9A
> > Currently, there have a bit platform provider (OEM/ODM) only return=
 the
> > _HOT, but didn't have _CRT value. But, if _HOT S4 fail, the system
> > components might dangerous if there have no any hardware protected
> > Mechanism.
> >=20
> > Thomas's idea is add a sysfs interface /sys/class/thermal/S4_capabl=
e for
> > userland to tell kernel userland component (pm-util or upower?) alr=
eady
> > take the _HOT event and try to do S4.
> >=20
> > How do you think about this idea?
>=20
> I'm not so sure, this sounds a bit like an ad-hoc interface for a pre=
tty
> specific problem. I would expect, it needs more integration than a
> global sysfs flag that keeps its state even when no userland process =
is
> taking care anymore.
>=20
> The details should probably be discussed on a mailing list like
> devkit-devel@lists.freedesktop.org and the people working on the
> userspace integration side should comment on it.
>=20

It's Kay's suggestion from userland side, do we need discuss with more
guys from desktop side?

Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
