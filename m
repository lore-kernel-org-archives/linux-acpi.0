From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: could not map ACPI
Date: Tue, 21 Jan 2003 17:10:02 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030121161002.GF15023@poup.poupinou.org>
References: <3E2D3471.1070307@paceblade.com> <20030121131925.GB14593@poup.poupinou.org> <3E2D5879.6020908@symplon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E2D5879.6020908-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Robert <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 21, 2003 at 03:26:01PM +0100, Robert wrote:
> 
> 
> Ducrot Bruno schrieb:
> 
> >On Tue, Jan 21, 2003 at 12:52:17PM +0100, Robert Woerle Paceblade/Support 
> >wrote:
> > 
> >
> >>Hi
> >>
> >>When i use mem=XXXM ACPI works fine , BUT i get cruel crashes when using 
> >>Sound and Ethernet or/and usb togethere ( they all have IRQ 5 ) one 
> >>device alone is fine .
> >>When i dont use mem=XXXM i get an error at /drivers/acpi/tables/tb_get.c
> >>BUT all the devices work fine , even together !!!
> >>i tried also mem=XXXM + acpi=nopci  which gives the same result : ACPI 
> >>works and the devices crash together ....
> >>the machine is a Transmeta driving machine ...
> >>

Ook.  Thank.  Could you please send me in private your dsdt (apologize then
if I got in the past..., but anyway that doesn't hurt :)
via something similar:

cat /proc/acpi/dsdt | gzip -c - | uuencode dsdt.gz | mail ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org -s '[ACPI] dsdt'

Thank in advance.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
