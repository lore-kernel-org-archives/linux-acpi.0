From: David Douard <douard-m7abxLq4WJJQFI55V6+gNQ@public.gmane.org>
Subject: Re: ACPI on the Compaq Presario 2800T
Date: Thu, 25 Jul 2002 19:59:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207251959.43272.douard@pl.ecp.fr>
References: <200207251708.NAA05377@department-of-alchemy.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200207251708.NAA05377-eUc2XO7YEjkUjpTVVQ/zfLxLbxdZZkq26YJIh+Me2V8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Le Jeudi 25 Juillet 2002 19:08, Sourav K Mandal a =E9crit :
> Hi,
>
> I'm running Gentoo Linux on a Compaq Presario 2800T
> with a vanilla 2.4.18 kernel, patched with
> acpi-20020709 and patch-acpi-acpi20020709-swsusp9.
> Unfortunately, suspend doesn't work, and there are no
> sleep, battery or fan  entries in /proc/acpi (the
> battery and fan modules load without complaint).
>
> From perusing the mailing lists, it seems that I require:
>
> * "nocorruption" patch

http://www.brodo.de/english/pub/acpi/20020709/bugfixes.html

> * a patch to fix the lack of a sleep CONFIG entry

by hand : add the line in linux/drivers/acpi/Config.in=20
      define_bool CONFIG_ACPI_SLEEP             y
after the line=20
      define_bool CONFIG_ACPI_POWER             y

> * a replacement DSDT since I have a Compaq
I think you must patch your own DSDT yourself (unless there is someone wh=
o=20
have done it before on the 2800T. You cannot use the DSDT of any other la=
ptop=20
for yours. Each DSDT contain very specific code).

> Where can I obtain these?  (I need URLs for the first two,
> I guess.)
>

You should have a look at :
http://www.pps.jussieu.fr/~jch/software/presario

too. And search the ML, there is huge info there, but quite hard to find.=
=2E.

David

> Thanks!
>
>
> Regards,
>
> Sourav
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by: Jabber - The world's fastest growing
> real-time communications platform! Don't just IM. Build it in!
> http://www.jabber.com/osdn/xim
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
