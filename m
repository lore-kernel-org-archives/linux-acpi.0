From: "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>
Subject: RE: fan control
Date: Tue, 6 May 2003 19:56:06 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <01bb01c313be$1845afc0$b8d21b2b@ADACHIPC>
References: <20030506092120.GA24982@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030506092120.GA24982-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-2022-jp?B?JxskQiVOGyhCcmljIEJydW5ldCc=?= <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> About fan control, I would love to be able to stop my fan, but it
doesn't
> work. I can echo anything to /proc/acpi/fan/FAN/state, it has no
bearing
> on the fan, and the only result is a line in the log:
> > acpi_bus-0199 [18] acpi_bus_set_power    : Device is not power
manageable
> (kernel is 2.5.67)
> 
acpi_bus_set_power() complains that the target device is not enabled to
be power managed as its "power_manageable" flag, which will be set for
devices who have _PS0 or _PR0 in DSDT upon device enumeration, is
__NOT__ set. And, indeed, your FAN device in DSDT doesn't explicitly
list its power resource by _PR0 Object.

   5369 000034ba: Scope _TZ_ (\_TZ_)
   5370 000034c2:   Device FAN_ (\_TZ_.FAN_)
   5371 000034c9:     Name _HID (\_TZ_.FAN_._HID)
   5372 000034ce:       PNP0c0b (0x0b0cd041)
   5373 000034d3:     Method _INI (\_TZ_.FAN_._INI)
   5374 000034d9:       ArgCount 0; NotSerialized
   5375 000034da:       Store
   5376 000034db:         TP1H (000032ad)
   5377 000034df:         CTOS
   5378 000034e3:       Store
   5379 000034e4:         TP1L (000032b2)
   5380 000034e8:         CTHY


Thanks,
- Adachi, Kenichi



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
