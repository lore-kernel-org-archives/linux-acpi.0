From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: resource for S3 suspend/resume of Radeon
Date: Mon, 17 Mar 2003 17:54:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030317165453.GC31491@dutidad.twi.tudelft.nl>
References: <1047912152.28830.32.camel@dutidad> <20030317153434.GB3936@hell.org.pl> <1047916074.28836.58.camel@dutidad> <20030317162624.GB2249@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030317162624.GB2249-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
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

On Mon, Mar 17, 2003 at 05:26:24PM +0100, Karol Kozimor wrote:
> Anyway, since the first 2.5 I used (2.5.59) I am able to suspend-to-RAM,
> then resume. Normally, the screen is off, and the keyboard is mute, but
> appending acpi_sleep=s3_bios does it for the screen, and reloading the
> atkeyb module brings the keyboard back to life. NIC needs several seconds
> (and several pings also) to resume (it's a rtl8139 chip).

I still need to find out why my laptop doesn't even want to begin waking up.
:)  Maybe it's very tired.

> > Drivers in the new kernel need to be able to suspend/resume (S1, S3 and
> > S4) without more than the minimum required support in the BIOS.
> 
> S4 is a bit easier. See this: I have radeonfb hard-compiled in the kernel.
> When I resume, the kernel that boots first initializes the display
> properly, and then the kernel that is read from swap has the display
> already running, so it doesn't have to worry about it. I suppose it would
> be much harder when radeonfb was compiled as a module. Then, I think that
> it's S3 that is the most difficult.

swsusp has worked perfectly for me for some time, at least ever since
http://cpbotha.net/dri_resume.html :)

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
