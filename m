From: Mahmood NT <mahmood.nt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ACPI question
Date: Fri, 18 Nov 2005 16:25:42 +0330
Message-ID: <1acba2fa0511180455s26c7192dyde34bec2565d8735@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4018_5941260.1132318542582"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

------=_Part_4018_5941260.1132318542582
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 Hello,
I have a DELL inspiron 510m running Fedora core 3 (2.6.9).
I have trouble with my ACPI. When ever I close the lid, the screen goes off
(I do not know whether it suspen to RAM or not).
But when I open the lid, it does not wake up and the screen still is off. I
must press the power button. therefore system shuts down
and I must restart it again.

First I thought that the problem is with ACPI daemon. so I disable it and
try to close the lid again. the same problem rose again.
I think that the kernel (or something like this) does not recognize the lid
button (or lid event).

The surprising thing is that, when I see the bootlog, it writes this:
ACPI wake up devices:
lid S1 S2 ......
it seems that it knows "lid" but do not know what it is !!!

What do you suggest?

--
Mahmood NT,

------=_Part_4018_5941260.1132318542582
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 Hello,<br>



I have a DELL inspiron 510m running Fedora core 3 (2.6.9).<br>



I have trouble with my ACPI. When ever I close the lid, the screen goes off=
 (I do not know whether it suspen to RAM or not).<br>



But when I open the lid, it does not wake up and the screen still is
off. I must press the power button. therefore system shuts down <br>



and I must restart it again.<br>



<br>



First I thought that the problem is with ACPI daemon. so I disable it
and try to close the lid again. the same problem rose again.<br>



I think that the kernel (or something like this) does not recognize the lid=
 button (or lid event). <br>



<br>



The surprising thing is that, when I see the bootlog, it writes this:<br>



&nbsp;&nbsp;&nbsp;&nbsp; ACPI wake up devices:<br>



&nbsp;&nbsp;&nbsp;&nbsp; lid S1 S2 ......<br>



it seems that it knows &quot;lid&quot; but do not know what it is !!!<br>



<br>



What do you suggest?<br clear=3D"all"><br>-- <br>Mahmood NT,

------=_Part_4018_5941260.1132318542582--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
