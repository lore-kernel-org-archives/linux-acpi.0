From: Ethan Glasser-Camp <glasse-IL7dBOYR4Vg@public.gmane.org>
Subject: Problems with T30
Date: Mon, 2 Sep 2002 11:10:12 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020902151012.GA892@rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello everyone, and sorry if I send this to the wrong mailing list.

I'm new to ACPI, in fact I'm new to laptops in general. I just got mine from my college as part of their mobile computing program -- they believe every student should have a portable computer. Anyhow, I did the natural thing and put Linux on it -- it's an IBM Thinkpad T-30 -- and now I'm having some trouble with it. Specifically:
- I can cat /proc/acpi/battery/BAT0/state and sometimes the first time it will work, but after the first time it is virtually guaranteed to give me "Large Reference Count" warnings as well as the error "Unable to read battery status".
- I can press a number of buttons on the keyboard and get "nsxfeval-0223 [number] Acpi_evaluate_object  : Handle is NULL and Pathname is relative" -- specifically the volume controls do this.
- This is my favorite: I can close the lid and get a kernel panic which completely wedges the system, requiring a hard reboot.

I have spent the past three or four days toying with the kernel, trying to convince it to allow me to compile debug messages into the ACPI modules. No can do. I'm not quite sure why, but if I try, make modules_install will give me unresolved symbol errors.

I used to be able to cat /proc/acpi/battery/BAT0/state and get an error I think resembling AF_IML_INTERNAL, but I twiddled with the source a little, which might be why I'm getting these errors now. (I think I added an else case to an if statement that didn't have one. I'm trying to find it now... I give up. I also added to the acpi_battery_read_state debug output so that it told me the state of a the recent result variable (it's -19).)

Anyone have any ideas on how to solve any of these problems? I believe that there's a bug in the BIOS or in the table interpreter, but I don't know how to go about troubleshooting them.

Thanks for whatever help you have.

Ethan Glasser-Camp


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
