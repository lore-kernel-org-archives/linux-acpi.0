From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Issue reading files under /proc/acpi using python.
Date: Thu, 6 Feb 2003 14:49:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030206134924.GQ1205@poup.poupinou.org>
References: <200302062245.44847.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200302062245.44847.harisri-bzGI/hKkdgRBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Srihari Vijayaraghavan <harisri-bzGI/hKkdgRBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 06, 2003 at 10:45:44PM +1100, Srihari Vijayaraghavan wrote:
> Hello,
> 
> While I can read /proc/acpi files fine using 'cat', python is unable to read 
> files under that directory.
> 
> Here is how you can reproduce the issue:
> 

Don't know.

I have:

ducrot@novae:~$ python2.2
Python 2.2.1 (#1, Jul 29 2002, 23:15:49) 
[GCC 2.95.4 20011002 (Debian prerelease)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> print file("/proc/acpi/battery/BAT1/state").read()
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      2040 mAh
present voltage:         14800 mV

>>> print file("/proc/acpi/battery/BAT1/info").read()
present:                 yes
design capacity:         4000 mAh
last full capacity:      4000 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 420 mAh
design capacity low:     156 mAh
capacity granularity 1:  264 mAh
capacity granularity 2:  3780 mAh
model number:            PA3098U 
serial number:           3658Q
battery type:            Li-Ion
OEM info:                TOSHIBA

>>> print file("/proc/version").read()
Linux version 2.4.21-pre3 (root@novae) (gcc version 2.95.4 (Debian prerelease)) #3 Tue Feb 4 16:30:11 CET 2003

>>> 
ducrot@novae:~$ python2.2 -V
Python 2.2.1

libc 2.25.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
