From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Daemon that handles ACPI
Date: Wed, 26 Mar 2003 18:24:11 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A231@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>, Stephen Torri <storri-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: S=E9rgio Monteiro Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]=20
> and talking about ospmd, yes, it never worked, we have a=20
> missing config
> file that make GUI doens't work, and in this case I never knew about =
a
> basic example...=20
> Normally is the thing that is missed on every man and help pages of
> Linux :)=20

OK so here's the deal with ospmd:

It works. On my RH 8 machine. ;-) Specifically, the qt include path is
hardcoded in the gui Makefile. Bad, bad, I know. But look, the raw =
materials
of what I envision for a power policy daemon and power library are =
there:

- ospmd handles *both* ACPI and APM kernel interfaces, and presents a
uniform PM interface. Other PM interfaces could be easily supported, =
too.

- ospmd creates a config file with default values, and these can be =
changed
in the .conf file (/var/ospmd.conf) or can be set via libpower.

- libpower presents a rich, uniform interface for power applets to use.
Power policy is centralized, so changes made through a kde and gnome =
applet
(for example) both affect the same policy. Applets and battery meters =
no
longer have to parse /proc, or perform battery life calculations - =
libpower
handles it.

- further enhancements could include APIs for apps to request that the
screen not be blanked (e.g. presentation apps) or to keep the system =
out of
suspend (e.g. cd writing apps).


I really believe strongly that ospmd (or something like it) will be the =
way
to go for a standard PM policy daemon and interface in the future. I am
frustrated that ACPI kernel issues and other work have prevented me =
from
productionalizing it with man pages, better build system, better test =
gui,
etc. but I think this will be a very important part of a modern =
system's
power management architecture.

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
