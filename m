From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: hda: dma_timer_expiry: dma status == 0xff ...
Date: Tue, 1 Jul 2003 20:20:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030701182028.GN7796@poupinou.org>
References: <200307011942.43703.hrvoje.habjanic@htnet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200307011942.43703.hrvoje.habjanic-ZeoyiJGIzEM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hrvoje Habjanic <hrvoje.habjanic-ZeoyiJGIzEM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 01, 2003 at 07:42:43PM +0200, Hrvoje Habjanic wrote:
> 
> Hi!
> 
> Waking up from S1 or S3 ... everything frozes and that message starts showing 
> on console ... every 10 seconds ...
> 
> I don't have a clue!!! 
> 
> If these messages get out, i guess, that interrupts are working (tried with 
> pci=noapic and pci=noacpi).
> 
> Funny thing, if i redirect console to serial port, serial port continue to be 
> responsive (bash is working ok), BUT any disk access "frezzes" the hole 
> machine up - those message start displaying on console and that's it, even 
> serial port stops responding.
> 
> What to try/look for??
> 

The ide hwif is puzzled.  Try to see if you can have datasheet for, then
do a lspci -xxx to it before and after suspension, you may
then look if the config for dma stuff are different.
Then add .suspend .resume codes for it, if that is not already done, or
debug them.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
