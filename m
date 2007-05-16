From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: 2.6.22-rc1-mm1 [cannot change thermal trip points]
Date: Wed, 16 May 2007 13:47:39 -0400
Message-ID: <464B43BB.3070505@redhat.com>
References: <20070515201914.16944e04.akpm@linux-foundation.org> <464B4155.9070902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:38052 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757398AbXEPRta (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 May 2007 13:49:30 -0400
In-Reply-To: <464B4155.9070902@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org

Maciej Rutecki wrote:
> In 2.6.20.9 I can change trippoints:
>=20
> echo "105:100:100:78:70:40:30" > /proc/acpi/thermal_zone/TZ0/trip_poi=
nts
> echo 10  > /proc/acpi/thermal_zone/TZ0/polling_frequency
>=20
> Then I got:
> cat /proc/acpi/thermal_zone/TZ0/*
> <setting not supported>
> cooling mode:   active
> polling frequency:       10 seconds
> state:                   active[2]
> temperature:             45 C
> critical (S5):           105 C
> active[0]:               78 C: devices=3D0xdf415a40
> active[1]:               70 C: devices=3D0xdf4159dc
> active[2]:               40 C: devices=3D0xdf41598c
> active[3]:               30 C: devices=3D0xdf41593c
>=20
> cat /proc/acpi/fan/*/*
> status:                  off
> status:                  off
> status:                  on
> status:                  on
>=20
> And fan turns on.
>=20
> In 2.6.22-rc1-mm1:
> echo "105:100:100:78:70:40:30" > /proc/acpi/thermal_zone/TZ0/trip_poi=
nts
> bash: echo: write error: B=C4=B9=C2=82=C3=84=C2=85d wej=C4=B9=C2=9Bci=
a/wyj=C4=B9=C2=9Bcia (input/output error)
>=20
> rutek:/home/maciek# cat /proc/acpi/thermal_zone/TZ0/*
> <setting not supported>
> polling frequency:       10 seconds
> state:                   ok
> temperature:             45 C
> critical (S5):           256 C
> active[0]:               78 C: devices=3D0xc1827a40
> active[1]:               70 C: devices=3D0xc18279dc
> active[2]:               60 C: devices=3D0xc182798c
> active[3]:               50 C: devices=3D0xc182793c
> rutek:/home/maciek# cat /proc/acpi/fan/*/*
> status:                  off
> status:                  off
> status:                  off
> status:                  off
>=20
> Fan turns on when temperature is over 50*C. (want: 30)
>=20
> A read this:
> http://article.gmane.org/gmane.linux.acpi.devel/22750
>=20
> But I don't have colling_policy, but only colling_mode:
> ls /proc/acpi/thermal_zone/TZ0/
> cooling_mode  polling_frequency  state  temperature  trip_points
>=20
> Its bug or feature?
>=20

Committed to mainline May 10:

Gitweb:     http://git.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/li=
nux-2.6.git;a=3Dcommit;h=3D11ccc0f249cb01a129f54760b8ff087f242935d4
Commit:     11ccc0f249cb01a129f54760b8ff087f242935d4
Parent:     de46c33745f5e2ad594c72f2cf5f490861b16ce1
Author:     Len Brown <len.brown@intel.com>
AuthorDate: Mon Apr 30 22:36:01 2007 -0400
Committer:  Len Brown <len.brown@intel.com>
CommitDate: Mon Apr 30 22:36:01 2007 -0400

    ACPI: thermal trip points are read-only
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
