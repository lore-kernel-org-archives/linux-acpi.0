From: Mads Paulin <paulin-/w0Os/Ss2Sh/SzgSGea1oA@public.gmane.org>
Subject: Re: acpi and 2.6.0 kernel - S3 doesn't resume, S4 =
	infinite loop
Date: Mon, 22 Dec 2003 10:59:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1072087165.2411.1.camel@M2400N>
References: <3FE6A4EF.6070002@psu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FE6A4EF.6070002-8DAjSxpRXgY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nirmal Govind <nirmalg-8DAjSxpRXgY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have just done exactly the same - just on a Mandrake 9.1 box
I tried this on an ASUS M2400N laptop also with the i855 chipset

The results were the same - only a hard reebot boot was working.

Regards,
Mads

On Mon, 2003-12-22 at 09:01, Nirmal Govind wrote:
> Hi.. I just compiled the 2.6.0 kernel that was released on Dec. 
> 18th... I have ACPI support with all the options enabled. I tried 
> suspending with S3 and it suspends fine (my power indicator starts 
> flashing which means that it has suspended). But when I hit the 
> power button, it does not resume properly, it tries to resume, the 
> power indicator stops flashing which means that it thinks it's woken 
> up, but all I see is a blank screen and hitting any of the keys 
> doesn't seem to do anything. Only thing that works is a hard reboot. 
> I'm running Mandrake 9.2 on a Fujitsu Lifebook S series (6120D) with 
> an Intel 855 chipset graphics adapter. Please let me know if there's 
> a way to get S3 to work well.
> 
> Also, I tried suspend with S4 and that suspended fine but when I 
> tried to resume, it booted up, showed me the resume messages saying 
> it was resuming, then reboots! And this keeps happening at each 
> reboot -- an infinite loop basically. I finally had to boot without 
> the resume= option to get it to boot properly. Is this a bug?
> 
> Thanks,
> nirmal
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
