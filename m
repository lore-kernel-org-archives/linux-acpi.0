From: Robert <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Subject: Re: could not map ACPI
Date: Wed, 22 Jan 2003 09:10:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E2E51FD.3070902@symplon.com>
References: <3E2D3471.1070307@paceblade.com> <20030121131925.GB14593@poup.poupinou.org> <3E2D5879.6020908@symplon.com> <20030121204235.GJ15023@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030121204235.GJ15023-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Robert Woerle Paceblade/Support <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Ducrot Bruno schrieb:

>On Tue, Jan 21, 2003 at 03:26:01PM +0100, Robert wrote:
>  
>
>>Ducrot Bruno schrieb:
>>
>>    
>>
>>>On Tue, Jan 21, 2003 at 12:52:17PM +0100, Robert Woerle Paceblade/Support 
>>>wrote:
>>>
>>>
>>>      
>>>
>>>>Hi
>>>>
>>>>When i use mem=XXXM ACPI works fine , BUT i get cruel crashes when using 
>>>>Sound and Ethernet or/and usb togethere ( they all have IRQ 5 ) one 
>>>>device alone is fine .
>>>>When i dont use mem=XXXM i get an error at /drivers/acpi/tables/tb_get.c
>>>>BUT all the devices work fine , even together !!!
>>>>i tried also mem=XXXM + acpi=nopci  which gives the same result : ACPI 
>>>>works and the devices crash together ....
>>>>the machine is a Transmeta driving machine ...
>>>>
>>>>So when i look at tb_get.c at the specific functions...
>>>>i see that it maps the pointers there according to a 
>>>>switch(adress->pointer) call !
>>>>Is possible that it normally uses the
>>>>case ACPI_LOGMODE_PHYSPTR:
>>>>stuff but when i use mem=XXX
>>>>it might use the other case statement:
>>>>case ACPI_LOGMODE_LOGPTR:
>>>>
>>>>can i make a cruel hack around that that it always uses the working one 
>>>>???
>>>>
>>>>        
>>>>
>
>The problem is that the BIOS call to retrieve memory infos give 'false'
>information on how the memory controller is configured.
>This is the messages you see as <4> BIOS-e820: ...  (...)
>
>and the code is in asm at very early stage of initialisation in
>arch/i386/boot/setup.S via int15 with param e820h.
>In fact, the acpi tables should go to a 'special' type (the ACPI data
>one) but I don't see anything at all in the BIOS-e820 calls.
>
My first thought was that i do  a cruel hack where in this stage 
(setup.S ) i do  a minus - XXX at the total RAM
I think the whole problem is that this is a Trasnmeta Crusoe machine at 
there are 16 MB RAM always taken by the
CodeMorphing Technology and the BIOS doesnt remind that and doesnt 
report the correct values !!!
I heard from other emails in this list that i might be possible to patch 
the DSDT to the correct values ??


That is what i thought from the beginning ... and since our BIOS 
Resources are very low these days , i would gladly get an Info
how i could cruely workaround that for now to get everything done , 
since we plan our big kickout for the "Linux Tablet PC" for CEBIT(March 
) this year
together with Suse .
If we togther get it to run , you will get a small donation for sure !!!

>
>I want to verify now if your DSDT table have correct infos on how
>the memory controller have to be configured.
>
>
>  
>



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
