From: Stephan Krings <stephan-MC3rjLPHZ0jJ0Y7HFzmx4Q@public.gmane.org>
Subject: Re: Compaq evo n800v
Date: Mon, 10 Mar 2003 21:37:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15980.63370.956274.280152@hotzenplotz.chateau-neukoelln.de>
References: <1047125223.5077.28.camel@localhost.localdomain>
	<15980.22695.764082.140067@hotzenplotz.chateau-neukoelln.de>
	<20030310100824.GB32516@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030310100824.GB32516-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Anders Persson <anders.persson-sT6loi8rTDSci/EUP2OQSw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hello,

> I wouldn't be so sure -- I have an Asus L380C with a Radeon M7 and I've
> had no problems changing brightness so far, be it with, or without DRI.

On the Evo N800c I'm using right now, I got the impression that
changing the display brightness does completely bypass the ACPI
system. The associated keys (Fn+F7 or Fn+F8) do not show up on the
console (at least showkey shows nothing for them) and patching some of
the DSDT methods with debug statements did not show anything.

So I guessed changing the display brightness would write directly into
some of the registers of the graphics card. But of course I may be
simply wrong here :-).

Regards and thanks for the input,

Stephan


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
