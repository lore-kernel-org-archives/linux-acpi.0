From: Srihari Vijayaraghavan <harisri-bzGI/hKkdgRBDgjK7y7TUQ@public.gmane.org>
Subject: Issue reading files under /proc/acpi using python.
Date: Thu, 6 Feb 2003 22:45:44 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200302062245.44847.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

While I can read /proc/acpi files fine using 'cat', python is unable to r=
ead=20
files under that directory.

Here is how you can reproduce the issue:

$ cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         65120 mWh
last full capacity:      61627 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 6156 mWh
design capacity low:     0 mWh
capacity granularity 1:  1480 mWh
capacity granularity 2:  1480 mWh
model number:            4000
serial number:           1
battery type:
OEM info:                 COMPAQ
$
$ cat /proc/version
Linux version 2.4.21-pre4-acpi (hari-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org) (gcc version =
3.2=20
20020903 (Red Hat Linux 8.0 3.2-7)) #1 Thu Feb 6 00:12:06 EST 2003
$
$ python
Python 2.2.1 (#1, Aug 30 2002, 12:15:30)
[GCC 3.2 20020822 (Red Hat Linux Rawhide 3.2-4)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> file("/proc/acpi/battery/BATO/info").read()
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
IOError: [Errno 2] No such file or directory: '/proc/acpi/battery/BATO/in=
fo'
>>> file("/proc/version").read()
'Linux version 2.4.21-pre4-acpi (hari-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org) (gcc version=
 3.2=20
20020903 (Red Hat Linux 8.0 3.2-7)) #1 Thu Feb 6 00:12:06 EST 2003\n'
>>>

Softwares involved:
Kernel: Linux-2.4.21-pre4 + acpi-20030125-2.4.21-pre3.diff.gz
Rest all as in Red Hat 8.0 (with official updates)
(BTW same behavior is observed with Red Hat beta 8.1, which has updated=20
versions of gcc, glibc, python etc..)

It will be great if I can read all the ascii text files under /proc/acpi =
using=20
python, like /proc/cpuinfo, /proc/meminfo, /proc/version etc.. files.

Thanks
--=20
Hari
harisri-bzGI/hKkdgRBDgjK7y7TUQ@public.gmane.org



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
