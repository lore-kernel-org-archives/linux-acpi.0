From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Re: 2.5.39 Insomniac, any first dbg?
Date: Mon, 30 Sep 2002 17:44:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1033400645.7338.17.camel@bacchus.gpphy.uni-duesseldorf.de>
References: <200209301541.47910.p_christ@hol.gr>
 <1033398342.7338.5.camel@bacchus.gpphy.uni-duesseldorf.de>
 <200209301612.28344.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <200209301612.28344.p_christ-U04EIuiosng@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Mon, 2002-09-30 um 15.12 schrieb P. Christeas:
> I guess that's the point to start from. Did you say there was some code 
> splitting in sleep.c? Last kernel that runned fine for me was 2.5.36 (I 
> couldn't cleanly compile .37 and .38).

IIRC Patrick Mochel splitted the sleep stuff out from system.c into
sleep.c in 2.5.37

> It seems as if the code code in sleep.c doesn't call anything. It was 
> interesting, though that S2 did something, where it really wasn't supposed 
> to. The /proc entries should be fine. So, the bug must be after the 
> 'switch(state){ \n case 1: '. You 'll need to add some trace messages in the 
> early state of those fn's.

Hmmm...just had a quick look at the code...can you _confirm_ that
acpi_system_write_sleep gets called and that state has a correct value
(aka the one you echoed to /proc/acpi/sleep) after the following line:

state = simple_strtoul(state_string, NULL, 0);?

Since software_suspend() gets called from there and IIRC thats not part
of the acpi subsytem I wonder why S4 would not work in case state is 
correctly set there...

Anyway, thats only a quick shot assumption so do not flame in case 
I am plain wrong ;)

-Knut

-- 
Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Physikalische Grundpraktika - Heinrich-Heine Universitaet Duesseldorf
Raum 25.33.01.63  -   Universitaetsstrasse 1   -  D-40225 Duesseldorf
fon: +49-211-81-11314                           fax: +49-211-81-13105











-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
