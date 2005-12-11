From: Ronald Wielink <ronald.mythtv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: unable to set alam using echo to /proc/acpi/alarm
Date: Sun, 11 Dec 2005 22:29:30 +0100
Message-ID: <302c0a190512111329i76e9e214v4aff822d99ae5de5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_18555_2923758.1134336570590"
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

------=_Part_18555_2923758.1134336570590
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear all,
when I try setting the alarm to wake up my pc I get the following result:

[root@mithrandir acpi]# pwd
/proc/acpi
[root@mithrandir acpi]# cat alarm
2005-12-00 00:00:00
[root@mithrandir acpi]# echo 2005-12-15 17:18:19 > alarm
[root@mithrandir acpi]# cat alarm
2005-12-00 17:18:19
[root@mithrandir acpi]#

BTW, nothing happens at the echo'd date/time. Could someone please give me =
a
clue where to start looking?  I'm running fedora core 4, my mobo is an ASUS
P5S800-VM, the documentation on the motherboard states that ACPI is
supported. There is an option to turn acpi 2.0 on, but no difference...

Any help is greatly appreciated!

Regards,

Ronald

------=_Part_18555_2923758.1134336570590
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear all,<br>
when I try setting the alarm to wake up my pc I get the following result:<b=
r>
<br>
[root@mithrandir acpi]# pwd<br>
/proc/acpi<br>
[root@mithrandir acpi]# cat alarm<br>
2005-12-00 00:00:00<br>
[root@mithrandir acpi]# echo 2005-12-15 17:18:19 &gt; alarm<br>
[root@mithrandir acpi]# cat alarm<br>
2005-12-00 17:18:19<br>
[root@mithrandir acpi]#<br>
<br>
BTW, nothing happens at the echo'd date/time. Could someone please give
me a clue where to start looking?&nbsp; I'm running fedora core 4, my
mobo is an ASUS P5S800-VM, the documentation on the motherboard states
that ACPI is supported. There is an option to turn acpi 2.0 on, but no
difference...<br>
<br>
Any help is greatly appreciated!<br>
<br>
Regards,<br>
<br>
Ronald<br>

------=_Part_18555_2923758.1134336570590--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
