From: Albert Schueller <schuelaw-23yYEaFFs4qVc3sceRu5cw@public.gmane.org>
Subject: Thermal trip_points, raise them?
Date: Tue, 20 Jan 2004 00:26:29 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040120002629.A21624@carrot.whitman.edu>
Reply-To: Albert Schueller <schuelaw-23yYEaFFs4qVc3sceRu5cw@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

Tue Jan 20 00:23:44 PST 2004

Hi,

After a brief search of the archives on this subject, I have the
following questions:

(I'm running ACPI that's in the stock 2.6.1 kernel, this is a debian
woody (mostly stable) machine, with, of course, the 2.6.1 kernel. )=20

	- Ever since I started running acpi on my Dell SmartStep 200N
	  I've been getting thermal shutdowns.  I suppose having them is
	  better than not having them, but even in a well-ventilated,
	  cool room, the machine will shutdown if I compile a kernel.
	  This is a 2GHz P4 (mobile).  It's clean inside, no dust.
	  According to the specs at Intel the chip is safe upto 100=B0C
	  (though maybe not the stuff around it, I don't know).

	  In
	 =20
	  /proc/acpi/thermal_zone/THR1/trip_points =3D 72 C
	  /proc/acpi/thermal_zone/THR2/trip_points =3D 78 C

	  well shy of the 100=B0C on the Intel spec.

	  I was planning to hack the acpi source and raise the trip
	  points to something like 80 and 86, but I can't find where
	  they're being set.  This makes me think that they're being
	  obtained from the BIOS somehow.

	  Is it ok to just:

	  cat "80 C" > /proc/acpi/thermal_zone/THR1/trip_points
	  cat "86 C" > /proc/acpi/thermal_zone/THR2/trip_points

	  I'll take responsibility for any thermal damage, I'm just
	  wondering if this will raise the trip_points for me.

	  Alternatively, would removing the thermal module before a big
	  job, like a kernel compile, and then reinserting it be ok?
	  Or, would it break the ACPI that's currently running?
	  (again I take responsibility for thermal damage).

	- Just out of curiosity, what is the difference between the ACPI
	  code in the stock 2.6.1 kernel and, say, the 2.6.1 patch
	  provided on the acpi.sf.net page?  (I know, I know, look at
	  the diffs.)  Are there different development groups for ACPI?
	  One that's getting their stuff into the current kernels, and
	  this group that provides a patch replacement?

Sorry if these are FAQ's.

A

--=20
Albert Schueller                                 Department of Mathematic=
s
Office Phone:  509-527-5140                      Whitman College
Public Key:  http://carrot.whitman.edu/gpg.key   Walla Walla, WA USA 9936=
2


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
