From: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Subject: Re: [PATCH] s3_bios and lcall $0xc000,$3
Date: Tue, 18 Feb 2003 14:29:19 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302181426010.22900-100000@godzilla.axis.se>
References: <1045572005.7077.40.camel@dutidad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1045572005.7077.40.camel-1Jw6Eky0yc0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 18 Feb 2003, Charl P. Botha wrote:
> If the X server is not using DRI, the BIOS initialisation is mostly
> sufficient, as X resets the correct video mode when one VT switches

DOes the X server react to the pm events then and does this resetting when 
resuming, without having to switch manually to the console before and back 
after ?

> back.  However, if one is using DRI, the BIOS initialisation is OFTEN
> not even close, so you have to do something like I did to the Radeon
> drivers: http://cpbotha.net/dri_resume.html

Just if someone is interested...

I found this somewhat interesting PM code in the GPL part of the nvidia 
binary driver. I wonder what the comment is talking about wrgds to APM vs. 
ACPI and if it might work now. Haven't tried... (the rm_power_management 
functions are in the binary-only part).

    switch (rqst)
    {
#if 0
        /* XXX PM HACK!! for now, let's try this */

        // our video bios doesn't support APM, only ACPI
        // for now, return an error to try and keep the machine
        // from entering suspend/resume, so as to not lose any
        // user's data.
        case PM_RESUME:
            nv_printf(NV_DBG_INFO, "NVRM: received PM resume event\n");
            rm_power_management(NV_STATE_PTR(lnv), 0, rqst);
            break;

        case PM_SUSPEND:
            nv_printf(NV_DBG_INFO, "NVRM: received PM suspend event\n");
            rm_power_management(NV_STATE_PTR(lnv), 0, rqst);
            break;
#endif
        default:
            nv_printf(NV_DBG_INFO, "NVRM: received unknown PM event: 
0x%x\n", rq
st);

/Bjorn



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
