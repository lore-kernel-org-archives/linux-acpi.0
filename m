From: "M. Warner Losh" <imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: Re: DSDT in initrd
Date: Fri, 23 May 2003 22:51:09 -0600 (MDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030523.225109.32721389.imp@bsdimp.com>
References: <F760B14C9561B941B89469F59BA3A84725A2B3@orsmsx401.jf.intel.com>
	<20030522080420.GA634@laptop.6bone.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030522080420.GA634-ScjxTogt4I4lGuH5DXb43w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: marks-h3GR0owD+wQ@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In message: <20030522080420.GA634-ScjxTogt4I4lGuH5DXb43w@public.gmane.org>
            Mark Santcroos <marks-h3GR0owD+wQ@public.gmane.org> writes:
: Linux people might want to look at how FreeBSD does this.
: However, as Andy states, this is not ACPI specific, it means an overhaul
: for the whole Linux booting process.

Basically, for those unfamiliar, FreeBSD has a three stage boot.
First stage know just enough to load the second stage.  Second stage
knows enough about file systems to load a third stage.  Third stage
can load kernels, modules and pass information to the kernels.  Very
handy for thoese sorts of situations.  While the first two stages very
from arch to arch, the third stage is basically the same on all
architectures (although there is a md component to is that handles
processor specific relocation goo, etc).

Loading DSDT tables in FreeBSD is just another thing that the loader
can load before transferring control to the kernel.

Warner


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
