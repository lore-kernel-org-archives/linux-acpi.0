From: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: FW: ACPI breakage in 2.6.2-rc3 (and before)
Date: Sun, 1 Feb 2004 10:27:48 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7F740D512C7C1046AB53446D37200173B135D3@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
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

Forwarding potential degradation in 2.6.2-rc3.

Jun
-----Original Message-----
From: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
[mailto:linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Joseph Pingenot
Sent: Sunday, February 01, 2004 12:20 PM
To: Linus Torvalds
Cc: Kernel Mailing List
Subject: ACPI breakage in 2.6.2-rc3 (and before)
Importance: High

>From Linus Torvalds on Friday, 30 January, 2004:
>The bulk of this is an ACPI update, but there's USB, ia-64, i2c, XFS
and=20
>PCI hotplug updates here too.
>Please don't send in anything but critical fixes until after the final=20
>2.6.2 release.

Hmm.  I just tried 2.6.2-rc3 (after having tried 2.6.1 after having
  tried 2.6.2-rc2-mm1), and I note that ACPI can get my battery
  status in 2.6.1, but *not* in 2.6.2-rc2-mm1 or in 2.6.2-rc3.
  It notes that there is a battery in one of the two bays, and
  that it's on battery or AC power, but nothing more; all status
  readouts say that the battery's drained.

System is a Dell Inspiron 8600.

Thanks!


-Joseph
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
