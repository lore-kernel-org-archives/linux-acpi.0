From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI: Battery information?
Date: Wed, 9 Jun 2004 09:54:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040609075401.GT13782@poupinou.org>
References: <40C4FD27.7000805@users.xeroprj.org> <20040608092045.72e15c4c@tethys.solarsys.org> <20040608094707.GM13782@poupinou.org> <40C58F45.2040108@users.xeroprj.org> <20040608113456.GN13782@poupinou.org> <40C6319A.7080707@users.xeroprj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40C6319A.7080707-BC6XjCpM3eF0abU8S3f8Vti2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Binary Xerroz <xerroz-BC6XjCpM3eF0abU8S3f8Vti2O/JbrIOy@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 08, 2004 at 02:37:30PM -0700, Binary Xerroz wrote:
> Included is the output of acpidmp, also i included a diff patch for
> kernel 2.6.6, patched with patch from acpi.sf.net
>    About the battery.c, the main reason for my modifications is
> because to me ACPI for linux doesnt expect a battery to be removed
> (physically) such as on a laptop. the modified code reruns check
> routines to make sure the battery is still there, if not its updated as
> no present; before it still showed as present, but had critical status
> and such, this patch fixes that and updates accordingly. Double check
> routines added to make it work on status update instead of two.
> Anything else, let me know.

ACPI support hotplug of batteries if the hardware generate an SCI (an
interrupt), then a handler is called which will call an AML method which
in turn will call a special opcode (Notify()).
Then, after a Notify(FOO, 0x80) (or 0x81),
drivers/acpi/battery::acpi_battery_notify() will be called which will
reprobe the battery FOO (and (re)attach or detach to the acpi bus
if needed).

So it's more likely a trouble somewhere in your DSDT, or a bug under linux.

It may be also the case that the hardware do not support this scheme,
(the problem is that the interrupt used for this is not the same for APM
and ACPI, and hardware need to be configured of the mode of operation.
It's done at init stage of kernel).

So one step perhaps to debug this is to see if interrupts are generated.
You can, for example, do a 
watch -d 'cat /proc/interrupts'
then see if the interrupt associated to acpi change whenever you
plug/unplug a battery.

btw, your acpidump.bz2 seems to be corrupted somehow.  Could you please
resend it?

ps: my email client do not support HTML.  Would be fine if you can send
at least a text alternative somehow.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
