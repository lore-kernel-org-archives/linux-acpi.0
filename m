From: Lindsey Simon <lsimon-kAMMLXQ8Af9Wk0Htik3J/w@public.gmane.org>
Subject: Re: Unable to turn fan on - Asus M3N - 2.6.0-test9bk4
Date: Tue, 4 Nov 2003 11:32:16 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031104173216.GH26114@austinchronicle.com>
References: <20031101193817.GA19198@austinchronicle.com> <20031102174730.GB2819@krikkit> <3FA561F7.5030706@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FA561F7.5030706-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

My FN00/state's change from on to off as well, but the fan doesn't actually
turn on when the state says it's on.

Do you insmod the fan module or not? I do, but maybe I shouldn't?

Which of the ACPI modules do you turn on and which do you not?

Maybe that's the ticket?

Luca Capello in message Re: [ACPI] Unable to turn fan on - Asus M3N - 2.6.0-test9bk4 (Sun, 11/02 20:58):

> Hello,
> 
> on 11/02/03 18:47, Robert Vollmert wrote:
> >are you sure the fan doesn't turn on? What kind of temperatures have
> >you been seing? As Karol noted, the fan isn't controlled the way the
> >spec intends (which would require implementing n fan devices for an
> >n-level fan, I think). Instead, TCHG is called every time the
> >temperature changes, which sets the fan speed directly based on some
> >threshold temperatures which vary based on cooling mode
> >(active/passive). That's the only place you can take influence wihtout
> >modifying the DSDT, though changing the mode to passive will increase
> >the thresholds. IIRC, these temperatures are quite high, though I don't
> >remember exact values. In the region of 70?C, for the lowest, I think.
> I think the fan is correctly managed, as you can see from my attached:
> =====
> luca@gismo:~$ cat /proc/acpi/thermal_zone/THRM/temperature
> temperature:             68 C
> luca@gismo:~$ date
> Sun Nov  2 20:50:06 CET 2003
> luca@gismo:~$ cat /proc/acpi/thermal_zone/THRM/temperature
> temperature:             55 C
> luca@gismo:~$ date
> Sun Nov  2 20:52:44 CET 2003
> luca@gismo:~$ cat /proc/acpi/fan/FN00/state
> status:                  on
> luca@gismo:~$ cat /proc/acpi/fan/FN00/state
> status:                  off
> luca@gismo:~$
> =====
> 
> The temperature went high compiling the kernel, but suddenly the fan 
> went on and at high RPM (I could hear it), just for 5min and then it 
> went normal again.
> 
> I have always the 'os_wait_semaphore' problem, but, as Karol said in 
> another post, this doens't cause any big problems, just the already 
> reported keyboard bug (for less than 5min you can't type anything or if 
> you were typing sometimes it's as if you go on typing the last character).
> 
> Thx, bye,
> Gismo / Luca
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?   SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
