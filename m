From: David Douard <douard-nJJpUPIbDOA@public.gmane.org>
Subject: Re: performance problems?
Date: Tue, 19 Nov 2002 15:40:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211191540.58738.douard@magic.fr>
References: <3DDA3E96.50906@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DDA3E96.50906-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas List <Thomas.List-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

not sure about it, but have you any debug info on in ACPI ? Maybe, try to put 
debug info off (echo "0" > /proc/acpi/debug_level ), and see if that change 
anything.
I say that cause I used to have a lag due to debug info (which I must admit I 
put to a quite hight level, producing many data).

For the question about polling, it should be possible, according to specs (if 
I remember well, I'm not very sure) to have ACPI send an exception, thus 
catch it (with ospmd, acpid or whatever daemon you want) only when bat status 
changes. But for now, I have never been able to make my laptop work like 
this... But my compaq has such a buggy DSDT... And maybe probably harware 
bugs too (in interrupts lines)... That's bad cause software polling is never 
the right way to do such things here (temperature monitoring should not be 
polled either... In my DSDT, I have two functions, one which should be called 
when temp grows up,  one for down. None of them is ever called.).

David Douard

Le Mardi 19 Novembre 2002 14:37, Thomas List a écrit :
> Hi all,
>
> I'm working on a small battery applet for my laptop that reads out the
> battery status. As I have up to now no better idea I'm pulling the
> battery status (/proc/acpi/battery/...) every few seconds (anyone an
> idea of how to do this better?). Now a battery applet should consume as
> few CPU cycles as possible to not use up the battery itself. So I'm
> trying to monitor how much computing time my applet is using. For the
> moment I'm doing this using top (I know this is not perfect for that
> task ...). Now to the problem:
>
> After the laptop is running for some time the CPU% value in top is
> getting higher and higher. It starts with around 0.3% in the beginning,
> after one hour it reaches 1,5% and I had it up to 3% and more after a
> longer time. I am quite sure this is not my applet - I can stop the
> program and restart it and still get the higher values. I tried to watch
> a video in this state and while my program was running I had short stops
> in the video play back that match the 2 seconds interval of pulling the
> battery status. Without my program running the stops disappeared.
> Using a file system copy of /proc/acpi my program does not show at all
> on the top list.
>
> I am using acpi 20021111 on a 2.4.20-rc1 kernel. The laptop is a Targa
> visionary 1600 from actebis (mobile athlon on a Via ProSavage KN133
> "TwisterK" board). I think I did not have such problems with an older
> acpi version (20021022 ???) - I will check this out).
>
> Now could this be a problem with the acpi implementation or is this the
> result of a wrong usage of acpi?
>
>
> Btw. - is there any documentation on the /proc/acpi directories besides
> Dominik Brodowski's documentation for /proc/acpi/processor?
>
> Thanks for any help,
>
>    Thomas
>
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by: To learn the basics of securing
> your web site with SSL, click here to get a FREE TRIAL of a Thawte
> Server Certificate: http://www.gothawte.com/rd524.html
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
