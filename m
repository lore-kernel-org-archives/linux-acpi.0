From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: acpi breaking synaptics mouse support on Acer Travelmate
 260
Date: Tue, 12 Aug 2003 18:54:38 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030812185342.X89772@root.org>
References: <20030812221751.GA2432@man.beta.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, petero2-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 13 Aug 2003, Santiago Garcia Mantinan wrote:
> I recently (the 11th) posted on lkml a message with subject "2.6.0test3
> problems on Acer TravelMate 260 (ALSA,ACPIvsSynaptics,yenta)" on which I
> commented all the major problems I was seing on this machine.
>
> The machine is a PIII mobile at 1GHz with intel chipset (i82801+i830M) 256
> Megs of RAM the mouse is a Synaptics touchpad. The problem is that the mouse
> gets crazy (if using the normal mouse driver) or looses sync (if using the
> synaptics driver). I have looked at the interrupts happening when one moves
> the mouse and the number is much higher (from 3 to 10 times) in 2.6 compared
> with 2.4, also when one stops moving the mouse in 2.6 the interrupts keep on
> happening for half a second or so, while it stops inmediately in 2.4.

I don't use linux but perhaps there is an interrupt sharing problem that
appears when interrupts are routed differently (as they probably are
between 2.4 and 2.6).

-Nate


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
