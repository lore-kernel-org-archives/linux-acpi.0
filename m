From: =?iso-8859-1?Q?=D8ystein_Gisn=E5s?= <oysteigi-zs2scLodJVNRyvKAgBWctw@public.gmane.org>
Subject: /proc/acpi/ac_adapter/AC0/state not being updated
Date: Fri, 14 May 2004 17:05:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040514150548.GD12765@jaguar.stud.ntnu.no>
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

I have this problem with the state of the ac_adapter not being
updated. The state is set correctly on startup, but never change after
that. So if I boot with power cord disconnected, it correctly says
      state:                   off-line
but it doesn't change when I plug it in. The battery's charging state
is updated, however.

Is this a problem related to the ACPI implementation, the DSDT or
something else?


I've had this problem for 3 months giving the same symptoms with Linux
2.4.24 w/ACPI patches and 2.6.{3-6}. My laptop is a Fujitsu Siemens
Amilo D 7830.

dmesg gives this output if boot is made with power cord disconnected:
      ACPI: AC Adapter [AC0] (off-line)

AC adapter status works well in Windows.

--=20
=D8ystein Gisn=E5s <oysteigi-zs2scLodJVNRyvKAgBWctw@public.gmane.org>
NTNU, Department of Telematics
Mob: (+47) 98861515 - MSN: oysteing-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
