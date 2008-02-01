From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Subject: Re: 2.6.24-git9 ACPI oops - regression
Date: Fri, 1 Feb 2008 22:17:34 +0100
Message-ID: <20080201211734.GD4199@ics.muni.cz>
References: <20080201132551.GA4199@ics.muni.cz> <200802011529.20167.rjw@sisk.pl> <200802011207.03211.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761021AbYBAVST@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802011207.03211.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 01, 2008 at 12:07:03PM -0500, Len Brown wrote:
> this worked in 2.6.24?

At least in 2.6.24-rc8 seemed to be OK, for the first time, I encounter=
ed the
bug in 2.6.24-git4. 2.6.24-git6 seemed to be OK. 2.6.24-git9 is not.=20

> You are running the "dock" driver in both cases?

I use thinkpad acpi module, ACPI_DOCK is always built in.

> Is this reproducible?

In 2.6.24-git4, it was 100% reproducible - just pressing undock button =
on the
dock and the oops has been generated.

In 2.6.24-git9, I do not know, whether it is reproducible or not. And a=
s I'm
ill and my dock is in work, I'm not sure when I be ready to test it aga=
in.

> If yes, please open a bugzilla entry here:
>=20
> http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
> Component =3D Config-hotplug
>=20
> and attach the output from acpidump

do you need just acpidump as is or should I do acpidump when docked?

--=20
Luk=E1=B9 Hejtm=E1nek
