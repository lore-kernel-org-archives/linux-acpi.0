From: Perry Hutchison <phutchis-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: AE_NO_MEMORY <--- What it means, is there a fix?
Date: Wed, 27 Jul 2005 16:25:34 -0700 (PDT)
Message-ID: <200507272325.QAA60480@riparian.beaverton.windriver.com>
References: <200507271815.30711.gkanis@cems.umn.edu>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507271815.30711.gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
> Date: Wed, 27 Jul 2005 18:15:30 -0500
>
> I have a laptop which came with 2 memory modules 256MB each ...
> Today, I bought a 1GB at 533Mhz memory module ...  dmesg gives
> a lot of messages about the "AE_NO_MEMORY" ...

You aren't by any chance using a patched your DSDT?  If so, you
may need to merge your patches into the new base version that your
firmware is now providing to describe the additional memory.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
