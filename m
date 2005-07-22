From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: 2.6.13-rc3 Kernel Panic...
Date: Fri, 22 Jul 2005 23:01:09 +0200
Message-ID: <42E15E95.70904@tzi.de>
References: <42DEC727.6050108@tzi.de> <20050722102446.05daf2ae.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050722102446.05daf2ae.rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: randy_dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> The common ways are:
> - use a serial console
My laptop dosen'T have a serial port..., or is there a way to use USB 
for that ?
> - use netconsole (kernel config option + netcat on another system)
it's an ACPI bug, it happens before the networkcard is even initalized
> - use a smaller console font
I hacked the Kernel oops mesage, so I could see what was the last 
message before the oops:

Executing all Device _STA and _INI methodes

after this commes a big trace, here a few lines...

default_wake_function
acpi_ex_exit_interpreter
__down_failed
.text.lock.ec
acpi_ec_space_handler
acpi_ec_space_handler
acpi_ev_address_space_dispatch

If anybody is interested in the full stack trace, say it, then I will 
type it all in by hand...

    Janosch


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
