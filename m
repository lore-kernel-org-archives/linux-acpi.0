From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: could not map ACPI
Date: Tue, 21 Jan 2003 14:19:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030121131925.GB14593@poup.poupinou.org>
References: <3E2D3471.1070307@paceblade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E2D3471.1070307-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Robert Woerle Paceblade/Support <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 21, 2003 at 12:52:17PM +0100, Robert Woerle Paceblade/Support wrote:
> Hi
> 
> When i use mem=XXXM ACPI works fine , BUT i get cruel crashes when using 
>  Sound and Ethernet or/and usb togethere ( they all have IRQ 5 ) one 
> device alone is fine .
> When i dont use mem=XXXM i get an error at /drivers/acpi/tables/tb_get.c
> BUT all the devices work fine , even together !!!
> i tried also mem=XXXM + acpi=nopci  which gives the same result : ACPI 
> works and the devices crash together ....
> the machine is a Transmeta driving machine ...
> 
> So when i look at tb_get.c at the specific functions...
> i see that it maps the pointers there according to a 
> switch(adress->pointer) call !
> Is possible that it normally uses the
> case ACPI_LOGMODE_PHYSPTR:
> stuff but when i use mem=XXX
> it might use the other case statement:
> case ACPI_LOGMODE_LOGPTR:
> 
> can i make a cruel hack around that that it always uses the working one ???
> 

Can I see the dmesg without mem options?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
