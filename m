From: Sergio Visinoni <piffio-9zdaV+82baBg9hUCZPvPmw@public.gmane.org>
Subject: Re: Issue reading files under /proc/acpi using python.
Date: Thu, 6 Feb 2003 13:30:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030206133039.A10882@piffio.homelinux.org>
References: <200302062245.44847.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200302062245.44847.harisri-bzGI/hKkdgRBDgjK7y7TUQ@public.gmane.org>; from harisri-bzGI/hKkdgRBDgjK7y7TUQ@public.gmane.org on gio, feb 06, 2003 at 10:45:44 +1100
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

* Srihari Vijayaraghavan (harisri-bzGI/hKkdgRBDgjK7y7TUQ@public.gmane.org) wrote:
> While I can read /proc/acpi files fine using 'cat', python is unable to read 
> files under that directory.
> 
> Here is how you can reproduce the issue:
> 
> $ cat /proc/acpi/battery/BAT0/info
[snip]

> >>> file("/proc/acpi/battery/BATO/info").read()
> Traceback (most recent call last):
>   File "<stdin>", line 1, in ?
> IOError: [Errno 2] No such file or directory: '/proc/acpi/battery/BATO/info'
> >>> file("/proc/version").read()

well BATO != BAT0... you're using a capital o (letter) instead of a 0 (number)

Greetings,
Sergio Visinoni


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
