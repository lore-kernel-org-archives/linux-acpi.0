From: Carsten Rietzschel <cr7-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
Subject: Re: [BKPATCH] ACPI for 2.6
Date: Sat, 19 Jun 2004 23:22:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406192322.18821.cr7@os.inf.tu-dresden.de>
References: <E1BbPIM-00044a-0A@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1BbPIM-00044a-0A-ek0oC1U1TqqnvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I saw=20
<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/06/17 1.1608.11.11)
=A0 =A0[ACPI] avoid spurious interrupts on VIA
=A0 =A0http://bugzilla.kernel.org/show_bug.cgi?id=3D2243
within the Changeset.

So I patched my kernel and rebooted. There's still:
  spurious 8259A interrupt: IRQ7.
in dmesg output.

Was it a fix for this problem? If so, it seems still unsolved.
Of course I'll send you more infos if you need them. Just ask :)

Regards,
Carsten



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
