From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: Bad power savings with high network traffic
Date: Sun, 18 Jan 2004 18:37:40 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0401181824220.1440@tweety.gaugusch.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

[I'm not subscribed, please CC: me on answers! Thanks!]
I had my laptop connected to a network with lots of multicast/broadcast
traffic (40kb broadcast + 80kb multicast/sec). The multicast traffic was
only visible on the network meter, when promiscous mode was enabled.

Usually my CPU temperature is around 50=B0C when being idle, but it raise=
d
up to 54=B0C! I found out, that although CPU usage was minimal (1-2%), th=
e
C1 state was used very frequently. After unplugging the network cable, th=
e
temperature went down again.

My kernel is 2.4.24 with software suspend patch and realtek 8139 ethernet
card. I suppose, that kernel internal code doesn't honor C-states or
something like that?

Markus

--=20
__________________    /"\
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus(at)gaugusch.at  X     Against HTML Mail
                      / \


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
