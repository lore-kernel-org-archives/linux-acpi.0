From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [PATCH] pnpacpi mishandles port io ADDRESS resources
Date: Sat, 10 Jun 2006 22:51:13 +0200
Message-ID: <pan.2006.06.10.20.51.12.109916@free.fr>
References: <20060610164150.GR1651@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161003AbWFJUv1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Le Sat, 10 Jun 2006 10:41:50 -0600, Matthew Wilcox a =E9crit=A0:

>=20
> ACPI ADDRESSn resources can describe both memory and port io, but the
> current code assumes they're descibing memory, which isn't true for H=
P's
> ia64 systems.
>=20
There already a patch for that in -mm kernel

Matthieu
