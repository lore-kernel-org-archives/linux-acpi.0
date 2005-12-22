From: Paul Mathews <pma5201-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: problems reading battery state
Date: Wed, 21 Dec 2005 21:50:02 -0800 (PST)
Message-ID: <20051222055002.57425.qmail@web35612.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-921391894-1135230602=:57105"
Content-Transfer-Encoding: 7bit
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

--0-921391894-1135230602=:57105
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,
I have been trying to get my laptop (a Toshiba L25-S1192) to read the bat=
tery status, but have as of yet failed. ACPI appears to be working, the k=
ernel correctly identifies there is a battery present, as well as the pow=
er button and lid switch. It also properly catches the event of pressing =
the power button once, and shuts down. However, I have not found a way to=
 get it to get the battery status. I do get the following in /var/log/mes=
sages:

Dec 21 22:11:44 localhost kernel:     ACPI-0508: *** Error: Method execut=
ion failed [\_SB_.BAT1._BST] (Node d7e8d500), AE_NOT_FOUND
Dec 21 22:12:14 localhost kernel:     ACPI-0339: *** Error: Looking up [Z=
00D] in namespace, AE_NOT_FOUND
Dec 21 22:12:14 localhost kernel: search_node d7e8d600 start_node d7e8d60=
0 return_node 00000000

I am currently using Ubuntu Breezy, with a custom 2.6.14.3 kernel. Can th=
is problem be fixed with a custom dsdt table? I have tried the ACPI optio=
ns as modules, and compiling them straight in, with and without toshiba A=
CPI support (just in case) - neither has any effect.

My ACPI kernel config:
#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=3Dy
# CONFIG_ACPI_SLEEP is not set
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dm
CONFIG_ACPI_VIDEO=3Dm
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=3Dm
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
CONFIG_ACPI_TOSHIBA=3Dm
CONFIG_ACPI_BLACKLIST_YEAR=3D0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set

Thanks in advance
Paul



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
--0-921391894-1135230602=:57105
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<div id=3D"RTEContent">Hi,<br>I have been trying to get my laptop (a Tosh=
iba L25-S1192) to read the battery status, but have as of yet failed. ACP=
I appears to be working, the kernel correctly identifies there is a batte=
ry present, as well as the power button and lid switch. It also properly =
catches the event of pressing the power button once, and shuts down. Howe=
ver, I have not found a way to get it to get the battery status. I do get=
 the following in /var/log/messages:<br><br>Dec 21 22:11:44 localhost ker=
nel:&nbsp;&nbsp;&nbsp;&nbsp; ACPI-0508: *** Error: Method execution faile=
d [\_SB_.BAT1._BST] (Node d7e8d500), AE_NOT_FOUND<br>Dec 21 22:12:14 loca=
lhost kernel:&nbsp;&nbsp;&nbsp;&nbsp; ACPI-0339: *** Error: Looking up [Z=
00D] in namespace, AE_NOT_FOUND<br>Dec 21 22:12:14 localhost kernel: sear=
ch_node d7e8d600 start_node d7e8d600 return_node 00000000<br><br>I am cur=
rently using Ubuntu Breezy, with a custom 2.6.14.3 kernel. Can this probl=
em be fixed with a custom dsdt table? I have tried
 the ACPI options as modules, and compiling them straight in, with and wi=
thout toshiba ACPI support (just in case) - neither has any effect.<br><b=
r>My ACPI kernel config:<br>#<br># ACPI (Advanced Configuration and Power=
 Interface) Support<br>#<br>CONFIG_ACPI=3Dy<br># CONFIG_ACPI_SLEEP is not=
 set<br>CONFIG_ACPI_AC=3Dm<br>CONFIG_ACPI_BATTERY=3Dm<br>CONFIG_ACPI_BUTT=
ON=3Dm<br>CONFIG_ACPI_VIDEO=3Dm<br># CONFIG_ACPI_HOTKEY is not set<br>CON=
FIG_ACPI_FAN=3Dm<br># CONFIG_ACPI_PROCESSOR is not set<br># CONFIG_ACPI_A=
SUS is not set<br># CONFIG_ACPI_IBM is not set<br>CONFIG_ACPI_TOSHIBA=3Dm=
<br>CONFIG_ACPI_BLACKLIST_YEAR=3D0<br># CONFIG_ACPI_DEBUG is not set<br>C=
ONFIG_ACPI_EC=3Dy<br>CONFIG_ACPI_POWER=3Dy<br>CONFIG_ACPI_SYSTEM=3Dy<br>#=
 CONFIG_X86_PM_TIMER is not set<br># CONFIG_ACPI_CONTAINER is not set<br>=
<br>Thanks in advance<br>Paul<br><br></div><p>___________________________=
_______________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail =
has the best spam protection around <br>http://mail.yahoo.com=20
--0-921391894-1135230602=:57105--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
