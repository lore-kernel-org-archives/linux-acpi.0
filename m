From: Loic Jaquemet <ljaquemet-BNG0eM9rGRi0IRkH3yUr9EW4647UYGdYQQ4Iyu8u01E@public.gmane.org>
Subject: Re: performance problems?
Date: Tue, 19 Nov 2002 13:54:43 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DDA42A3.35F6BFE1@gatwick.westerngeco.slb.com>
References: <3DDA3E96.50906@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

i'am using 2.4.19 + around october patch ( I'll check that this evening )
on sony vaio fx502

I've experienced the same problem with my personnal adaptation of wmacpi ..

when I fetch the /proc/acpi/<batteriesxxx>/state|info files, I get a 1-2
second freeze| lag ..

It might be linked with acpi as at this precise instant I can see some
kacpid processes briefly created ..

Maybe the battery-status fetching lag is a hardware limitation ?

I'm not sure, but i think i didn't have this problem on pre-september
patches ..

++

Thomas List wrote:

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
> Btw. - is there any documentation on the /proc/acpi directories besides
> Dominik Brodowski's documentation for /proc/acpi/processor?
>
> Thanks for any help,
>
>    Thomas
>
> -------------------------------------------------------
> This sf.net email is sponsored by: To learn the basics of securing
> your web site with SSL, click here to get a FREE TRIAL of a Thawte
> Server Certificate: http://www.gothawte.com/rd524.html
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--
+----------------------------------------------+
|Jaquemet Loic                                 |
|Intern in WesternGeco, Schlumberger in Gatwick|
|Phone: 44-(0)1293-55-6876                     |
|Eleve ingenieur en informatique FIIFO, ORSAY  |
+----------------------------------------------+
http://sourceforge.net/projects/ffss/
#wirelessfr @ irc.freenode.net





-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
