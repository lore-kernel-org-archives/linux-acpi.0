From: Robert <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Subject: Re: could not map ACPI
Date: Wed, 22 Jan 2003 16:03:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E2EB2C1.1010206@symplon.com>
References: <3E2D3471.1070307@paceblade.com> <20030121131925.GB14593@poup.poupinou.org> <3E2D5879.6020908@symplon.com> <20030121204235.GJ15023@poup.poupinou.org> <3E2E51FD.3070902@symplon.com> <20030122105316.GK15023@poup.poupinou.org> <3E2E7DBD.5040109@symplon.com> <20030122142525.GA18109@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030122142525.GA18109-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>
>Well, normally bios inform the OS that the ACPI data region is for 
>the usage of ACPI, and is located in the 'normal' RAM, no?
>Well, it's right also to thing that OSPM can tell then that
>regions marked as 'ACPI data' can be used for normal RAM usage.
>Perhaps Redmonds OS do that?
>
>Well, well.  I will look if we can (in general, not your perticuliar
>problem) use the ACPI data memory when we know that we can
>use them.
>
>Back to your trouble:
>Fortunately, we can add a e820 entry in arch/i386/kernel/setup.c
>Those, this prevent to make an cruel hack to arch/i386/boot/setup.S
>wich should be a little bit more harder..
>
>Basically, I add a memory region marked for acpi data use,
>in sanitize_e820_map().
>
>It's way more easy..  Could you please try without mem=xxx at all?
>
>I see also that you use 2.4.19.  Perhaps this patch will be
>OK for 2.4.19 but I am not sure at 100%.
>
>Cheers,
>
>  
>
Ok it boots up fine without mem=XX option i get ACPI to load ..... so 
gimme some time and i ll double check
if the system is still crashing  or not ...
but so far it looks nice ...

Rob




-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
