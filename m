From: tierra.y.libertad-hi6Y0CQ0nG0@public.gmane.org
Subject: Got the cause for missing button events on gigabyte ga-6bxd
Date: Tue, 23 Jul 2002 21:15:47 +0200 (MEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020723191550.58A2D5086@marcos.python.subname.de>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I think, I got the problem why button events on the gigabyte ga-6bxd
have only appeared with the acpi releases (20020329, 20020404):

When interrupts are routed with IOAPIC, there are no events, even not
with windows (Win98 had no problems, but XP with IOAPIC-Interrupts
doesn't seem to receive button events.) The releases 20020329 & 20020404
are dealing with the interrupts through the pci-irq-routing table and
without IOAPIC.

When I tested ACPI with a single-processor kernel without support for
APIC's, ACPI chooses to route the interrupts with PIC. In this case the
events are working without problems, with up-kernel and APIC enabled,
events don't work at all, same for SMP.

I don't have any idea about the cause for this strange behaviour and I'd
like to enable PIC-Routing with SMP too, but have no idea how to force
this.

Any help appreciated,
--=20
R=FCdiger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
