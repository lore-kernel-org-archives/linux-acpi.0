From: Francisco Castanheiro <fdc10056-9geRo0GdX4mLEkmxylLn4tBQ+izJFF1I@public.gmane.org>
Subject: Re: Is it possibile that ACPi messes my battery ...
Date: Wed, 2 Oct 2002 15:57:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210021557.22805.fdc10056@students.fct.unl.pt>
References: <20021001001656.GC9965@geolandia.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021001001656.GC9965-CwhMdJBTcbtgNr7TIQy98w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: antonio-OL5acaPONM41GQ1Ptb7lUw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 01 October 2002 01:16, Antonio G. - Geotronix wrote:
> Hi.
>
> I don't know if something like this is possible however I don't think so
> but yet I will ask the same. I have noticed that in a few month, without
> any heavy duty, my Li-ion battery for my Preassrio 710EA has declined in
> full capacity. While the cat of /proc/acpi/battery/BAT0/state has always
> told me that "design capacity: 53280 mWh" the "last full capcity:" has
> declined from "43200 mWh" to the now "26669 mWh".

I have a Presario 700EA, and i'm also getting this problem, i don't know if 
the problem is the battery or not. 
The cat of /proc/acpi/battery/BAT0 gives "design capacity: 52880 mWh" and 
"last full capcity: 26430 mWh". My laptop is 8 months old.The battery 
capacity declined in a short period, something about 3 weeks. This is very 
strange.

Does anyone else with a presario (or not) notice this?


>
> As a matter of fact even though 2-3 months ago ACPI was loseing
> interupts and was heating lot more than now (now there aren't lost
> interupt any more and the fan is almost always off) the battery would
> last some 1h 10min but now I only get 1h durability while I should
> almost be getting 2 hours as I've measured some 6000mWh drop every
> 15min. (on low use, C2 proc state and T0) (7x6000=42000 for 1h45min
> durability). I seem to be getting the same durabilty and charge
> capacity also under winXP so I think the problem is OS independent. I
> presume the life span of my battery has dropped in so short time (3
> months max):

I get the same results...


>
> a) because the battery is faulted (most presumable)
I don't even want to think if compaq denies the replacement of the battery...


> b) bad ACPI (old pathes, the june-july patches) messed the battery?????
Can someone tell if this is possible?


>
> Thanks

-- 
Francisco Castanheiro
EMail: fdc10056-9geRo0GdX4mLEkmxylLn4tBQ+izJFF1I@public.gmane.org
A sua loja online: www.shopizzy.com 
"The wise man doesn't give the right answers, he poses the right questions."



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
