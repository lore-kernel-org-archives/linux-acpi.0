From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Toshiba M30 - Fan does NOT switch on.
Date: Fri, 17 Dec 2004 18:51:18 +0100
Message-ID: <20041217175118.GM2140@poupinou.org>
References: <20041217162459.69320.qmail@web14104.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041217162459.69320.qmail-EshwSoXKzPCA/QwVtaZbd3CJp6faPEW9@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Cerutti <videobert-whZMOeQn8C0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 17, 2004 at 05:24:59PM +0100, Luca Cerutti wrote:
> Hello,
> 
> first of all, my configuration:
> HW: Toshiba Satellite M30
> SW: (on dual-boot) Debian 3.1
> - Kernel 2.6.8-1-686 deb
> - speedstep_centrino loaded as module
> - toshiba_acpi 0.18 loaded as module
> - acpi interface installed
> - acpid installed.
> 
> ISSUES:
> 1) ACPID
>  acpid DOES NOT appear to start: error message "cannot
> open /proc/acpi/events resource busy" (sort of)

One process can access /proc/acpi/events.  It's very likely that
a process is opening it.

> 2) FAN, TRIPPOINTS AND POLICIES
>  with trip_points set to "110:0:90:40:0" I can with
> ease reach temperatures of 50-55 C at full CPU speed
> (1600) and then I prefer to manually switch on the fan
> echoing into /proc/acpi/toshiba/fan or to "powersave"
> my cpufreq down to 600Mhz... what puzzles me is that
> the fan SHOULD switch on at 40C
> No matter what I'm echoing as cooling policy... IT
> ALWAYS STAYS on "passive" (not that I notice any
> effect of this"
> 
> This is becoming a little bit annoying because either
> i write a script that toggles the toshiba/fan on every
> time I'm boosting the cpu, or I may as well cook an
> egg on the chassis of the notebook.
> 
> Waiting for your answers I thank you in advance

AFAIK acpi_thermal support only fan objects given in the ACPI
namespace.  Since toshiba/fan is handled by a propritary
interface to the bios, it's not handled by ACPI thermal subsystem.

This also apply to any other fan drivers (like for example a sensor
supported by i2c).  A way (maybe?) to do things clean is to design
a generic thermal interface.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
