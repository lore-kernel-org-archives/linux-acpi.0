From: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Subject: Re: fan control
Date: Thu, 1 May 2003 20:33:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030501203309.B1662@fermat.unipv.it>
References: <20030501185137.C926@fermat.unipv.it> <1051813408.607.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1051813408.607.3.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>; from raul.aranda-fE4FmR91nWqXOwHavGvsmg@public.gmane.org on Thu, May 01, 2003 at 08:23:28PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Raul Aranda Blasco <raul.aranda-fE4FmR91nWqXOwHavGvsmg@public.gmane.org>
Cc: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > I understand this procedure might be very dangerous. How am I sure that, after
> > playing with the fans, the control of them goes back to the thermal zones?
> 
>   After stop it, try to compile a kernel, it must level up the
> temperature and spin up the fan.
> 

I think I didn't explain the question correctly. The fans and the thermal zones
do work well. No problems at all. I was just wondering about the consequences
of playing with the fans (like I did with changing their status). If I reboot,
then the next session is OK..., but within the same session, suppose I just
switch the fans from one to two and then back to one. Then, I start some heavy
job and the temperature increases. Will then the kernel spin the fun up or my
previous action prevents it from doing so?

Daniele


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
