From: Donald W Watson <dwatson-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Hibernate to LVM
Date: Thu, 13 Jan 2005 13:41:35 -0800
Message-ID: <OF97651F7F.22151B8B-ON87256F88.0076CB20-88256F88.00772C98@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	Boundary="0__=08BBE51BDFE54DB08f9e8a93df938690918c08BBE51BDFE54DB0"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: dwatson-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--0__=08BBE51BDFE54DB08f9e8a93df938690918c08BBE51BDFE54DB0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable






I am using the 2.6.10 kernel (linux-2.6.9.tar.bz2 with patch 2.6.10.bz2=
) on
an older IBM ThinkPad (T20 booted with acpi=3Dforce).

I have seen no discussion of the following in the archives.  Hibernate =
(S4)
does not work if the swap partition is on an LVM Logical Volume.  The
reason is that try_name (init/do_mounts.c) is unable to find the partit=
ion
in /sys/block.

Further, if a second swap partition is established on a regular partiti=
on
and referenced in the "resume" state in menu.lst, hibernate appears to
succeed, but on resume check_sig (kernel/power.swsusp.c) complains beca=
use
the swsusp_header signature is "SWAPSPACE2" rather than the hard-coded
"S1SUSPEND" which it expects.

Are these deliberate design decisions?

Sincerely,    Don Watson
Linux Technology and Solutions; Beaverton, OR
503-578-4861/TL: 775-4861; dwatson-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org=

--0__=08BBE51BDFE54DB08f9e8a93df938690918c08BBE51BDFE54DB0
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p>I am using the 2.6.10 kernel (linux-2.6.9.tar.bz2 with patch 2.6.10.=
bz2) on an older IBM ThinkPad (T20 booted with acpi=3Dforce).<br>
<br>
I have seen no discussion of the following in the archives.  Hibernate =
(S4) does not work if the swap partition is on an LVM Logical Volume.  =
The reason is that try_name (init/do_mounts.c) is unable to find the pa=
rtition in /sys/block.<br>
<br>
Further, if a second swap partition is established on a regular partiti=
on and referenced in the &quot;resume&quot; state in menu.lst, hibernat=
e appears to succeed, but on resume check_sig (kernel/power.swsusp.c) c=
omplains because the swsusp_header signature is &quot;SWAPSPACE2&quot; =
rather than the hard-coded &quot;S1SUSPEND&quot; which it expects.<br>
<br>
Are these deliberate design decisions?<br>
<br>
Sincerely,    Don Watson<br>
Linux Technology and Solutions; Beaverton, OR<br>
503-578-4861/TL: 775-4861; dwatson-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org</body></html>=

--0__=08BBE51BDFE54DB08f9e8a93df938690918c08BBE51BDFE54DB0--



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
