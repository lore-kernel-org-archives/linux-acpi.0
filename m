From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: System poweroff
Date: Mon, 30 Jun 2003 13:38:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1056976699.25574.324.camel@passion.cambridge.redhat.com>
References: <0ee801c33efa$cd80eaf0$2a0806c0@wiproxcoio3398>
	 <200306301339.45845.m.c.p@gmx.net> <3F0028B5.40400@relex.ru>
	 <0f3001c33f02$254b4440$2a0806c0@wiproxcoio3398>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <0f3001c33f02$254b4440$2a0806c0-mtNSFjsC3/e12yEdTghClg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: siva <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
Cc: Yaroslav Rastrigin <yarick-343whMTK1pU@public.gmane.org>, ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-06-30 at 13:21, siva wrote:
> Hi.
> 
> Thanks for the reply.
> 
> I do not want to use all the features of the APM (such suspend states) ...I
> just want to use the feature of powering off the system completely while run
> the "poweroff / halt -p" commands.
> So it is possible to do this without enabling the APM /ACPI, just by adding
> some lines of code in the Kernel.

Yes, you can do this if you really want to, but you need sufficient
documentation for your motherboard and chipset. You need to work out how
to make it tell the PSU to turn itself off.

You may be able to work this out by reverse-engineering the APM BIOS or
ACPI bytecode. There's nothing _special_ about them that makes them able
to turn the machine off -- they're only software, it's just that they're
binary-only software to which we don't have the source.

There's no fundamental reason why you shouldn't be able to write a
proper Linux driver; it's just that like so many other things with only
binary-only driver code, we don't seem to be able to get sufficient
documentation for it.

-- 
dwmw2



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
