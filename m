From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] S4Bios support for 2.4.20 + acpi-20021205
Date: Mon, 20 Jan 2003 19:47:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030120184750.GR11487@poup.poupinou.org>
References: <20021213155309.GG4327@poup.poupinou.org> <3E2A9826.6010709@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E2A9826.6010709-hi6Y0CQ0nG0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Martin Platter <mxp1-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 19, 2003 at 01:20:54PM +0100, Martin Platter wrote:
> > The issues I encounter are still present, then; so play with
> > it carrefully..
> Hi all!
> 
> I have just tried 2.4.20 + acpi-20021205+s4bios the suspend and resume does 
> work till it reaches
> 
> CPU context restored
> 
> after that it either hangs on
> 
> PCI: Enabling device 00:09.0 (0000->0003) // this is my eth0

btw, what is your card?

> 
> or if I am trying to disable eth0 prior suspend on
> 
> [ACPI Debug] String ... VIA Software SMI PMIO 2fh
> [ACPI Debug] String: ________________________
> [ACPI Debug] String: THRM_TMP
> [ACPI Debug] String: ________________________
> 
> 
> Are this the known issues you refered to in your posting? How do we solve 
> them ?

Nope.  The known issue are basically: rewrotte acpi_wakeup.S properly, same
for the processor fix code, also seek for possible memory corruption,
and others (especially usb stuff as well as pcmcia.  I forgot to mention
the agpgart stuff)...

> Ps: What do you mean by "play with it carefully" ? There is not a lot to 
> play with :-/

I mean that this code is in developpement, and it is not tested well in
a lot of machines especially if the devices are properly restored in a
working state (which is apparently what you hit).

'Play with it carrefully' mean that at least you should try it in single mode,
or best create a dedicated partition known to been crashed (due to possible
fs corruptions).


Thank for testing!

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
