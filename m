From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: resource for S3 suspend/resume of Radeon
Date: Mon, 17 Mar 2003 17:52:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030317165236.GB31491@dutidad.twi.tudelft.nl>
References: <1047912152.28830.32.camel@dutidad> <m3hea29d2d.fsf@pcpenn04.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m3hea29d2d.fsf-ksZHQmIzGzSqwiivBfVWcw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ole Myren Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 17, 2003 at 05:23:54PM +0100, Ole Myren Rohne wrote:
> 	* only supports the mobile chips in D2 mode, that is typically what
> 	* is used on Apple laptops,
> 
> If I'm guessing correctly, D2 is "clocks off, static registers
> preserved" while ACPI/S3 certainly means D3 (power off) -> even more
> device state to be restored.

I thought about something like this, but at least benh's work gives us
something to work with.

> > I don't have time to look at this right now, but will do so as soon as
> > another lazy weekend comes up.
> 
> If you haven't already done so, you might want get access to the ATI
> docs *before* your lazy weekend...

Urgh, then I have to become part of the xfree86/dri in-crowd.  I don't think
this can be easily organised in the near future.

Thanks,
Charl


-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
