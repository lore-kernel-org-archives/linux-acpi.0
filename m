From: Ole Myren Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>
Subject: Re: resource for S3 suspend/resume of Radeon
Date: 18 Mar 2003 07:36:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3d6kp9o6g.fsf@pcpenn04.cern.ch>
References: <1047912152.28830.32.camel@dutidad>
	<20030317153434.GB3936@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030317153434.GB3936-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> writes:

> provided I pass the acpi_sleep=s3_bios option.

...which probably shows that your BIOS is more helpful than what is on
the P2120 (cf our previous exchange about waking up the 8139too).

> The latter was only tested using VGA console, because AFAIK the framebuffer
> support in current 2.5 kernels is faulty

I think there is a bug in the 8MB special case of radeonfb memory sizing.

> Anyway, my Radeon seems to work quite fine.

...with your BIOS. 

IUC, there is no requirement that the BIOS should POST (or allow lcall
$0xc000,$3 to work) on S3 resume.

Ole





-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
