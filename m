From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: 2.5.39 Insomniac, any first dbg?
Date: Mon, 30 Sep 2002 16:12:28 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209301612.28344.p_christ@hol.gr>
References: <200209301541.47910.p_christ@hol.gr> <1033398342.7338.5.camel@bacchus.gpphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1033398342.7338.5.camel-s1IKGncK6J2OERECOqmV57dB6IYNvbhm87tLKu7D3g4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> > I echo to /proc/acpi/sleep. Nothing happens, nothing gets logged for 1,4.
> > I looked into kernel/suspend.c and acpi/sleep.c . Which fn's can cause
> > the sleep procedure to fail w/o notices?
>
> Not quite sure...I would start making sure that the kernel actually
> notices that something has been echoed to sleep. There must be some
> handling of sleep as a proc filesystem entry - maybe in sleep.c. Look
> for it. I think starting there makes sense. If you find anything..let me
> know...I would not have to do double work then.
>
> -Knut

I guess that's the point to start from. Did you say there was some code 
splitting in sleep.c? Last kernel that runned fine for me was 2.5.36 (I 
couldn't cleanly compile .37 and .38).
It seems as if the code code in sleep.c doesn't call anything. It was 
interesting, though that S2 did something, where it really wasn't supposed 
to. The /proc entries should be fine. So, the bug must be after the 
'switch(state){ \n case 1: '. You 'll need to add some trace messages in the 
early state of those fn's.

Thanks for the help.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
