From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: [Swsusp] Re: new DRI resume binary snapshots and patches
 available
Date: 11 Dec 2002 11:22:16 +0100
Sender: dri-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039602136.3042.8.camel@dutidad>
References: <20021203232507.GA1723@dutidad.twi.tudelft.nl>
	<m2el8oopys.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2el8oopys.fsf-I+/jYW0I6Y1pcJYJbGLfGQ@public.gmane.org>
Errors-To: dri-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:dri-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:dri-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
To: swsusp-LcL5texQODR2DW0IdvIQ2g@public.gmane.org
Cc: dri-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2002-12-11 at 10:38, Juan Quintela wrote:
>         could you told me what X version against are your dri
>         patches?
> 
> I am having a bad time (not being an XFree hacker) to merge the X part
> of your patch (the kernel patch was a no brainer).
> 
> Basically my problem is that there is not:
> - ati/radeon_common.h file (and I didn't found any of the other
>   DRM_RADEON_* diffs).
> - in the radeon_dri.c::RADEONDRIResume() has a call to
>   +    _ret = drmCommandNone(info->drmFD, DRM_RADEON_CP_RESUME); 
> 
>   I am completely unable to find that command in my XFree tree :(
> 
> I am using XFree86-4.2.1-11mdk.  We used the gatos patch, but old ati
> code don't have either that function :(

I have clarified the web page (http://cpbotha.net/dri_resume.html)
somewhat.  The patch is very specifically for DRI CVS and NOT for
4.2.x.  I don't think it'll work on 4.2.1 to tell you the truth.

Soon I am going to make sure that it applies cleanly on XFree86 HEAD CVS
as well for possible submission into the repository.  Those will be your
two options then: either XFree86 DRI CVS or XFree86 HEAD CVS.

Thanks,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
