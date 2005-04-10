From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Button problems
Date: Sun, 10 Apr 2005 11:30:30 +0000
Message-ID: <200504101130.30497.stefandoesinger@gmx.at>
References: <20050409221927.GA28709@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050409221927.GA28709-kdZ+H/N/Ve2ELgA04lAiVw@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Hadmut Danisch <hadmut-kdZ+H/N/Ve2ELgA04lAiVw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> - HP nx7000:
>
>   suspend to ram works. To wake the computer up I have to
>   press the main power button. The computer wakes up. But as
>   soon as everything is restored the ACPI routines detect
>   that the power button had been pressed (the one to wake it up) and
>   act as if the power button was pressed: The linux is shut down
>   (halt), which is obviously not what was expected.
You have to edit your acpid scripts(the one which handle the power button and 
the sleep button)
Method A is to disable any actions done on power button events. Method B is to 
create some marker in the suspend script, e.g. a file in /tmp or /dev/shm, 
before suspend. The power button handler checks for this file. If it's there 
it delets it, otherwise it shuts down the system

>
> - MSI S260:
>
>   The S260 has three buttons: Power button, Lid button, and
>   Sleep button (Fn+F12 "Zz"). /proc/acpi/button says that
>   all three buttons are recognized under ACPI. Power and Lid work,
>   but when the sleep button is pressed just nothing happens.
>   No log entry, no event, the acpid does not even wake up.
>
>   Any idea?  (under WindowsXP it works...)
No Idea here. Sorry. Broken DSDT?

Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
