From: "Rockefeller, Harry" <harryr-UjZhlPPWhclBDgjK7y7TUQ@public.gmane.org>
Subject: RE: list of events
Date: Tue, 27 Apr 2004 09:27:12 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B774920D825C2D4880A3C1B0D6EF941851E512@ssdmx.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=46rom 'man acpid':

FILES
       /proc/acpi/event
       /etc/acpi/
       /var/log/acpid=20

Just try hard buttons, ac-adapter, etc. and see what gets logged there.

To ask my own specific question related to Stefan's more general one:
With acpi debug compiled into kernel (2.6.5) I get terminal log
messages when my ac-adapter status changes, but it is *not* logged
to /var/log/acpid.  Why is that?

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Stefan Lutz
> Sent: Tuesday, April 27, 2004 5:08 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] list of events
>=20
> Hi,
>=20
> is there any list of events (maybe with a short additional info) of=20
> all possible acpi events the acpid daemon can handle? I am currently=20
> experimenting with thos daemon and it is a little bit tricky to find=20
> out how this events are named and where they are place inside the=20
> hierarchy. Thank you for any help.


This electronic email transmission, and any files transmitted with it, ma=
y contain confidential information and is intended solely for the use of =
the individual or entity to whom they are addressed. Any use, copying or =
disclosure by any other person is strictly prohibited. If you have receiv=
ed this transmission in error, please notify the sender via email.


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
