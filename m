From: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Subject: Re: PROBLEM: Executing /sbin/hwclock hangs 2.4.21-rc[12] with ACPI snapshot patches
Date: Mon, 19 May 2003 22:36:51 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305192236.53673.mflt1@micrologica.com.hk>
References: <200305251014.23474.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200305251014.23474.harisri-bzGI/hKkdgRBDgjK7y7TUQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Srihari Vijayaraghavan <harisri-bzGI/hKkdgRBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> [1.] One line summary of the problem:
> Executing /sbin/hwclock hangs 2.4.21-rc[12] with ACPI snapshot
> patches (acpi-20030424-2.4.21-rc1.diff.gz and
> acpi-20030512-2.4.21-rc2.diff.gz)

To circumvent hang: boot with ACPI=off

First detected in acpi20030424 with ali153x implementation on a toshiba libretto L2

May be related to ali southbridge in general. 

Temporary solution: Add --directisa to all hwclock calls in your scripts. See man hwclock.  Common scripts to change: rc.sysinit and halt

Regards
Michael



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
