From: Giacomo Rizzo <giacomorizzo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ACPI problem
Date: Fri, 7 Oct 2005 00:54:03 +0200
Message-ID: <3ebbb09c0510061554h5c19610al9d0ecfabf9707312@mail.gmail.com>
Reply-To: Giacomo Rizzo <giacomorizzo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_530_1035073.1128639243892"
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

------=_Part_530_1035073.1128639243892
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
Len Brown gave me your address because I talked to him
about a problem I'm having while trying installing linux (I tried
several distros)
The problem is that my notebook (a sony pcg-nvr23)
shuts down after a random number of seconds during the installation process=
.
I think it's an acpi problem because once I tried booting Knoppix by keepin=
g
the temperature around
my notebook really low (it was a really cold winter night)
Looking at /proc/acpi/temperature I realized that the cpu temperature was
getting higher and higher as the second passed, untill my computer turned
off.
Another weird thing is this. I installed Suse 9.1 always being in a cold
place and it seems that the temperature is quite stable (it's not so low bu=
t
at least it's far from upper limit). I would like to know if it's possible,
a way to install any linux distribution without keeping the notebook cool.
I tried to pass these options at boot time
acpi=3Doff
acpi=3Doff doapm
acpi=3Don
but none of these trys was successful.
Do you have any suggestion?
I hope so. Thanks anyway
Giacomo

------=_Part_530_1035073.1128639243892
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
Len Brown gave me your address because I talked to him<br>
about a problem I'm having while trying installing linux (I tried<br>
several distros)<br>
The problem is that my notebook (a sony pcg-nvr23)<br>
shuts down after a random number of seconds during the installation process=
.<br>
I think it's an acpi problem because once I tried booting Knoppix by keepin=
g the temperature around<br>
my notebook really low (it was a really cold winter night)<br>
Looking at /proc/acpi/temperature I realized that the cpu temperature
was getting higher and higher as the second passed, untill my computer
turned off.<br>
Another weird thing is this. I installed Suse 9.1 always being in a
cold place and it seems that the temperature is quite stable (it's not
so low but at least it's far from upper limit). I would like to know if
it's possible, a way to install any linux distribution without keeping
the notebook cool.<br>
I tried to pass these options at boot time <br>
acpi=3Doff<br>
acpi=3Doff doapm<br>
acpi=3Don<br>
but none of these trys was successful.<br>
Do you have any suggestion?<br>
I hope so. Thanks anyway<br>
Giacomo<br>

------=_Part_530_1035073.1128639243892--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
