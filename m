From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: could not map ACPI
Date: Wed, 22 Jan 2003 11:53:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030122105316.GK15023@poup.poupinou.org>
References: <3E2D3471.1070307@paceblade.com> <20030121131925.GB14593@poup.poupinou.org> <3E2D5879.6020908@symplon.com> <20030121204235.GJ15023@poup.poupinou.org> <3E2E51FD.3070902@symplon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E2E51FD.3070902-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Robert <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Robert Woerle Paceblade/Support <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 22, 2003 at 09:10:37AM +0100, Robert wrote:
> 
> 
> Ducrot Bruno schrieb:
> 
> >On Tue, Jan 21, 2003 at 03:26:01PM +0100, Robert wrote:
> > 
> >
> >>Ducrot Bruno schrieb:
> >>
> >>   
> >>
> >>>On Tue, Jan 21, 2003 at 12:52:17PM +0100, Robert Woerle 
> >>>Paceblade/Support wrote:
> >>>
> >>>
> >>>     
> >>>
> >>>>Hi
> >>>>
> >>>>When i use mem=XXXM ACPI works fine , BUT i get cruel crashes when 
> >>>>using Sound and Ethernet or/and usb togethere ( they all have IRQ 5 ) 
> >>>>one device alone is fine .
> >>>>When i dont use mem=XXXM i get an error at /drivers/acpi/tables/tb_get.c
> >>>>BUT all the devices work fine , even together !!!
> >>>>i tried also mem=XXXM + acpi=nopci  which gives the same result : ACPI 
> >>>>works and the devices crash together ....
> >>>>the machine is a Transmeta driving machine ...
> >>>>
> >>>>So when i look at tb_get.c at the specific functions...
> >>>>i see that it maps the pointers there according to a 
> >>>>switch(adress->pointer) call !
> >>>>Is possible that it normally uses the
> >>>>case ACPI_LOGMODE_PHYSPTR:
> >>>>stuff but when i use mem=XXX
> >>>>it might use the other case statement:
> >>>>case ACPI_LOGMODE_LOGPTR:
> >>>>
> >>>>can i make a cruel hack around that that it always uses the working one 
> >>>>???
> >>>>
> >>>>       
> >>>>
> >
> >The problem is that the BIOS call to retrieve memory infos give 'false'
> >information on how the memory controller is configured.
> >This is the messages you see as <4> BIOS-e820: ...  (...)
> >
> >and the code is in asm at very early stage of initialisation in
> >arch/i386/boot/setup.S via int15 with param e820h.
> >In fact, the acpi tables should go to a 'special' type (the ACPI data
> >one) but I don't see anything at all in the BIOS-e820 calls.
> >
> My first thought was that i do  a cruel hack where in this stage 
> (setup.S ) i do  a minus - XXX at the total RAM

I think your first though is the correct to go.  The problem why it
doesn't work is that you have to recreate yourself the correct mapping,
not only to reserve the top of mem as you have done.

For me, it sound like to be a critical bug in the firmware, that can
have the potential to bug some propritary OS (not only free OS).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
