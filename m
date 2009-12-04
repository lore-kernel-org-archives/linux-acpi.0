From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: Can't compile 2.6.32
Date: Fri, 4 Dec 2009 15:05:42 -0800
Message-ID: <20091204150542.e361a12a.randy.dunlap@oracle.com>
References: <c5bd819b0912040532x13b7e564ve7f37badb0aaa521@mail.gmail.com>
	<20091204142522.6de2c52e.randy.dunlap@oracle.com>
	<c5bd819b0912041430s78c86710y18097d7dd77bac0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:17225 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757374AbZLDXGH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2009 18:06:07 -0500
In-Reply-To: <c5bd819b0912041430s78c86710y18097d7dd77bac0e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grozdan <neutrino8@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 4 Dec 2009 23:30:09 +0100 Grozdan wrote:

> On Fri, Dec 4, 2009 at 11:25 PM, Randy Dunlap <randy.dunlap@oracle.co=
m> wrote:
> > On Fri, 4 Dec 2009 14:32:08 +0100 Grozdan wrote:
> >
> >> Hello,
> >>
> >> I'm having trouble trying to compile the 2.6.32 kernel on my openS=
USE
> >> 11.1 system. While doing so, I see a lot of warnings which seem to
> >> come from include/acpi/acpiosxf.h and then when the compile proces=
s
> >> enters the drivers/acpi directory, it errors out with the followin=
g:
> >>
> >> =C2=A0 CC =C2=A0 =C2=A0 =C2=A0drivers/acpi/tables.o
> >> In file included from include/acpi/acpi.h:63,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from=
 include/linux/acpi.h:39,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from=
 drivers/acpi/tables.c:33:
> >> include/acpi/acpiosxf.h: In function =E2=80=98acpi_load_override_t=
ables=E2=80=99:
> >> include/acpi/acpiosxf.h:98: warning: no return statement in functi=
on
> >> returning non-void
> >> =C2=A0 CC =C2=A0 =C2=A0 =C2=A0drivers/acpi/blacklist.o
> >> In file included from include/acpi/acpi.h:63,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from=
 include/linux/acpi.h:39,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from=
 drivers/acpi/blacklist.c:33:
> >> include/acpi/acpiosxf.h: In function =E2=80=98acpi_load_override_t=
ables=E2=80=99:
> >> include/acpi/acpiosxf.h:98: warning: no return statement in functi=
on
> >> returning non-void
> >> =C2=A0 CC =C2=A0 =C2=A0 =C2=A0drivers/acpi/osl.o
> >> In file included from include/acpi/acpi.h:63,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from=
 include/linux/acpi.h:39,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from=
 drivers/acpi/osl.c:40:
> >> include/acpi/acpiosxf.h: In function =E2=80=98acpi_load_override_t=
ables=E2=80=99:
> >> include/acpi/acpiosxf.h:98: warning: no return statement in functi=
on
> >> returning non-void
> >> drivers/acpi/osl.c: At top level:
> >> drivers/acpi/osl.c:514: error: redefinition of =E2=80=98acpi_load_=
override_tables=E2=80=99
> >> include/acpi/acpiosxf.h:98: error: previous definition of
> >> =E2=80=98acpi_load_override_tables=E2=80=99 was here
> >> make[2]: *** [drivers/acpi/osl.o] Error 1
> >> make[1]: *** [drivers/acpi] Error 2
> >> make: *** [drivers] Error 2
> >>
> >> Thoughts, solutions, etc?
> >
> > Please send your failing kernel .config file. =C2=A0Thanks.
>=20
> Hi Randy
>=20
> Attached is my config of 2.6.32

That builds fine for me, after I run make oldconfig and eliminate all o=
f the
opensuse config additions.

It could be acpi-header-related though.  Let's cc: linux-acpi to see if=
 they
know anything about this.

> >> PS: please CC me as I'm not subscribed to the list.
> >> --


---
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
