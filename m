From: "siva" <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
Subject: Re: System poweroff
Date: Mon, 30 Jun 2003 17:51:34 +0530
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <0f3001c33f02$254b4440$2a0806c0@wiproxcoio3398>
References: <0ee801c33efa$cd80eaf0$2a0806c0@wiproxcoio3398> <200306301339.45845.m.c.p@gmx.net> <3F0028B5.40400@relex.ru>
Reply-To: "siva" <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Yaroslav Rastrigin <yarick-343whMTK1pU@public.gmane.org>, ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

Thanks for the reply.

I do not want to use all the features of the APM (such suspend states) ...I
just want to use the feature of powering off the system completely while run
the "poweroff / halt -p" commands.
So it is possible to do this without enabling the APM /ACPI, just by adding
some lines of code in the Kernel.

Any idea?

Thanks,
Siva

----- Original Message -----
From: "Yaroslav Rastrigin" <yarick-343whMTK1pU@public.gmane.org>
To: "ACPI-Devel mailing list" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sent: Monday, June 30, 2003 5:40 PM
Subject: Re: [ACPI] System poweroff


> Hi !
> Marc-Christian Petersen wrote:
> > On Monday 30 June 2003 13:29, siva wrote:
> >
> > Hi Siva,
> >
> >
> >>My system is not getting powered off, if I issue a poweroff / halt -p  /
> >>init 0 command. Instead it is shutdowns the system and stops after
> >>displaying the following message "Power down". I haven't installed any
of
> >>the power management (APM / ACPI) option in my kernel.
> >>Is it because of that ?
> >
> > rotfl. Another troll?
> No, sir. One more clueless newbie. Just like you and I were some time ago.
> Please, be patient and tolerable.
>
> Siva:
> Yes, that's because you haven't installed neither APM nor ACPI. I would
> recommend to try APM first - it's less buggy at the moment.
>
> With all the best, yarick at relex dot ru
>
>
>
>
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
