From: "Udo A. Steinberg" <us15-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
Subject: Re: ACPI source releases updated (20030619)
Date: Tue, 24 Jun 2003 16:57:53 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030624165753.6ae5984c.us15@os.inf.tu-dresden.de>
References: <F760B14C9561B941B89469F59BA3A84725A2FE@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary=")IexIpwWjBx4,=.1"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A2FE-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--)IexIpwWjBx4,=.1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2003 11:30:49 -0700 Grover, Andrew (GA) wrote:

GA> New Linux 2.4 and 2.5 patches are now available from
GA> http://sf.net/projects/acpi. Big thanks to the asus-acpi team, as well
GA> as all the other people who have been tracking down bugs and submitting
GA> fixes lately.
GA> 19 June 2003.  Summary of changes for version 20030619:

Hi Andrew,

The new ACPI interpreter works much better and seems to mostly solve the
previous problems I had with ACPI on a Dual-Xeon machine with HT, see
http://bugme.osdl.org/show_bug.cgi?id=774

The excessive ACPI interrupts have ceased, but I still get exactly
100000 ACPI interrupts during bootup and then no more. Also the ACPI
interrupt seems to hit the e100 driver unexpectedly.

I've put up the dmesg output of 2.5.73 at the following URL:
http://hell.wh8.tu-dresden.de/dmesg-2.5.73.txt

Regards,
-Udo.

/proc/interrupts

           CPU0       CPU1       CPU2       CPU3       
  0:       5383          0     642910          0    IO-APIC-edge  timer
  2:          0          0          0          0          XT-PIC  cascade
  8:          1          0          0          0    IO-APIC-edge  rtc
  9:     100000          0          0          0   IO-APIC-level  acpi
 14:      11169          0          0          0    IO-APIC-edge  ide0
 16:          0          0          0          0   IO-APIC-level  uhci-hcd
 17:       2020          0          0          0   IO-APIC-level  eth0
NMI:          0          0          0          0 
LOC:     648031     648066     648066     648065 
ERR:          0
MIS:          0

--)IexIpwWjBx4,=.1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE++GbxnhRzXSM7nSkRArw+AKCC2gbCrm3uskKwVe9hjlp+fMUhkwCfe/Sp
gs+F42QNB671oWabcjxFPew=
=Uhu6
-----END PGP SIGNATURE-----

--)IexIpwWjBx4,=.1--
