From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Re: S3 suspend/resume driver questions
Date: 20 Apr 2004 10:52:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <yzon0572fr2.fsf@localhost.localdomain>
References: <32839.66.245.64.93.1082425332.squirrel@webmail.cc.gatech.edu>
	<20040420014614.GN8823@dreamcraft.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040420014614.GN8823-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tomasz Ciolek <tmc-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org>
Cc: Ilya Bagrak <reason-ss4n/k5RZhaUArH+D2fLrA@public.gmane.org>, brewt-acpi.sf.net-CDLCgzMZgTDYtjvyW6yDsg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>>>> "Tomasz" == Tomasz Ciolek <tmc-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org>

Tomasz>  If only someone at ATI or Fujitsu finnaly mamanged to cough up
Tomasz>  the magic incantations for the radeon cards so that the POST
Tomasz>  correctly... 

AFIK, POST on S3 resume is not mandated by the ACPI specs, so I'll
assume we'll have to do it ourselves:

1. The "lcall $0xc000,$3"-kludge in wakeup.S doesn't even know the PCI
   slot/function number, and it is probably way too early as bridges
   etc are not awake yet.

2. POST-on-VT change in X11 can be made to work but is rather dirty
   and it doesn't fix the text consoles.

3. POST using vm86 from radeon_pci_resume is probably The Right Thing
   (tm): It knows the PCI slot/function and it happens at the right
   time wrt bridges and stuff. This requires someone with the
   knowledge to write the lines of code and the energy to make it
   work. (Having a black screen as the only diagnostics isn't very
   inspiring in the long run.)

Ole


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
