From: Frank Van Damme <frank.vandamme-oe7qfRrRQffoK229JIzMLneTipRkpopC@public.gmane.org>
Subject: Re: ANNOUNCE: updated Radeon dri-resume binaries available
Date: Sat, 5 Apr 2003 22:47:31 +0200
Sender: dri-users-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304052247.31286.frank.vandamme@student.kuleuven.ac.be>
References: <20030405172822.GE13713@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <dri-users-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030405172822.GE13713-V1rPnKwUOrA59+mn7qD7y50iERQUc4G+@public.gmane.org>
Content-Disposition: inline
Errors-To: dri-users-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:dri-users-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:dri-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-users>,
	<mailto:dri-users-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-users>,
	<mailto:dri-users-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-users>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: dri-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, swsusp-LcL5texQODR2DW0IdvIQ2g@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Saturday 05 April 2003 19:28, Charl P. Botha wrote:
> I've updated the DRI Radeon resume-enabled driver binaries to a 20030405
> DRI CVS snapshot.  These are available at
> http://cpbotha.net/dri_resume.html for x86.
>
> The DRI CVS code has really improved drastically over the past few weeks
> and is better than the 4.3.0 resume-enabled driver code in several regards.
> The binaries are built on a Debian Stable system with gcc 2.95 so should
> work on just about any current distribution.
>
> Enjoy!

Hint for building the kernel module: make sure 
/lib/modules/kernelversion/build has your kernel headers in it. I symlinked 
/lib/modules/kernelversion/build/include to 
/usr/src/kernel-headers-version/include. 

-- 
Frank Van Damme    | "Saying 8MB of RAM doesn't do as much anymore is
http://www.        | like saying a gallon of water holds more than it
openstandaarden.be | did in 1988."                    --George Adkins



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
