From: Peter Osterlund <petero2-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Subject: Re: acpi breaking synaptics mouse support on Acer Travelmate 260
Date: 17 Aug 2003 21:15:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2ada8drjv.fsf@telia.com>
References: <20030812221751.GA2432@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-Message-Id: <200308172009.h7HK9qtW030539-dJtN/HGY7pUNCZHLCRkIHg@public.gmane.org>
Resent-To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
In-Reply-To: <20030812221751.GA2432-COUDbPDYh58xAGwisGp4zA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Santiago Garcia Mantinan <manty-gaW6/AuhO2xeoWH0uzbU5w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Santiago Garcia Mantinan <manty-gaW6/AuhO2xeoWH0uzbU5w@public.gmane.org> writes:

> The machine is a PIII mobile at 1GHz with intel chipset (i82801+i830M) 256
> Megs of RAM the mouse is a Synaptics touchpad. The problem is that the mouse
> gets crazy (if using the normal mouse driver) or looses sync (if using the
> synaptics driver). I have looked at the interrupts happening when one moves
> the mouse and the number is much higher (from 3 to 10 times) in 2.6 compared
> with 2.4, also when one stops moving the mouse in 2.6 the interrupts keep on
> happening for half a second or so, while it stops inmediately in 2.4.

Actually it is expected to see interrupts for about one second after
you stop touching the touchpad, if you are using the synaptics driver.
There is a feature in the synaptics hardware that keeps generating
packets for one extra second, to make it easier for drivers to
implement gesture decoding without having to rely on additional
software timers. Maybe you didn't use the synaptics driver in 2.4, in
which case the touchpad would emulate a standard mouse and not
generate the extra packets.

-- 
Peter Osterlund - petero2-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org
http://w1.894.telia.com/~u89404340


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
