From: Juan Quintela <quintela-7Aj/b8uzpy6AmYF/tR2SNQ@public.gmane.org>
Subject: Re: new DRI resume binary snapshots and patches available
Date: 11 Dec 2002 10:38:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2el8oopys.fsf@demo.mitica>
References: <20021203232507.GA1723@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021203232507.GA1723-V1rPnKwUOrA59+mn7qD7y50iERQUc4G+@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: swsusp-LcL5texQODR2DW0IdvIQ2g@public.gmane.org
Cc: dri-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>>>> "charl" == Charl P Botha <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org> writes:

Hi

charl> New binary snapshots of the DRI suspend/resume modified Radeon drivers are
charl> available at http://cpbotha.net/dri_resume.html - these are the first DRI
charl> suspend/resume driver snapshots since the merge of XFree86 HEAD into the DRI
charl> tree. The updated patches are of course also available at the mentioned URL.

        could you told me what X version against are your dri
        patches?

I am having a bad time (not being an XFree hacker) to merge the X part
of your patch (the kernel patch was a no brainer).

Basically my problem is that there is not:
- ati/radeon_common.h file (and I didn't found any of the other
  DRM_RADEON_* diffs).
- in the radeon_dri.c::RADEONDRIResume() has a call to
  +    _ret = drmCommandNone(info->drmFD, DRM_RADEON_CP_RESUME); 

  I am completely unable to find that command in my XFree tree :(

I am using XFree86-4.2.1-11mdk.  We used the gatos patch, but old ati
code don't have either that function :(

Any help or advice on where can I found the CVS change where the
drmCommandNone was introduced is welcome.  I looked at the Changelogs
and see no mention of that changes :(

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
