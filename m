From: "Dino Klein" <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Where can I find some documentation/examples?
Date: Thu, 08 Jan 2004 15:15:46 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Law11-F57d45M4kyMd500008bd9@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

One comment about removing - I didn't mean calling the serial device's 
remove method in the ACPI namespace, but rather having the serial driver 
call serial_unregister() to release the resources.
I would think that if the driver unregisters from the acpi bus, then it 
should also release the resources, after all, wouldn't it be possible that 
after the driver unregisters with the acpi bus, yet still holds the 
resources, couldn't a second serial driver come along and register for the 
same type of devices, and get the same serial device that is already handled 
by the first serial driver?


>On Wed, Jan 07, 2004 at 11:26:08PM -0500, Dino Klein wrote:
> > I've taken a look at the serial driver's use of acpi in order to 
>discover ports, and their resources (in kernel 2.6.0). One thing
> > puzzled me there, since it seems that it is possible to unload their 
>acpi related, and therefore having it call
> > acpi_bus_unregister_driver(); however, as far as I can tell, the serial 
>port itself is still being used by the serial driver. This
> > is why I'm not quite sure about the relationship between a regular linux 
>driver, and the acpi subsystem.
> > So, any pointers would be appreciated.
>
>You don't necessarily want to take that driver as a good example of
>what's needed to write an ACPI driver.  Actually somebody else just
>pointed out the same thing to me earlier today.  On the systems I work
>on, I use serial console, so it's pretty much mandatory to have 8250
>built in and hence the remove method never gets called ;-)
>
>Take a look at something like the button driver instead.

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
