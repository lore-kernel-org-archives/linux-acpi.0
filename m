From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: resource for S3 suspend/resume of Radeon
Date: 17 Mar 2003 16:47:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1047916074.28836.58.camel@dutidad>
References: <1047912152.28830.32.camel@dutidad>
	 <20030317153434.GB3936@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-03-17 at 16:34, Karol Kozimor wrote:
> Thus wrote Charl P. Botha:
> > lot of this code could be used to make ACPI S3 (suspend to RAM) a
> > reality on Radeon-using laptops.
> 
> Which radeon do you have in mind exactly? I use an M7 LW chip, and I get
> the following: both in 2.4.x and 2.5.x the display does not power-off when

You could try using the radeontool (google it) to remedy this.

> in S1 (which is, I believe, expected), and during S3 it poweroffs and comes
> back in, provided I pass the acpi_sleep=s3_bios option.

Wow, you mean to say that you can flawlessly S3 suspend/resume with
kernel 2.4?  I would assume that this is due to your laptop's support
for S3 in BIOS.  Not all laptops have this... see for instance what Ole
had to do to get his working:
http://home.cern.ch/mrohne/P2120/P2120_Linux_S3.html

Drivers in the new kernel need to be able to suspend/resume (S1, S3 and
S4) without more than the minimum required support in the BIOS.

Thanks,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
