From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: asus M5636NBP fan always on
Date: Mon, 28 Nov 2005 16:02:21 +0100
Message-ID: <20051128150221.GA2983@elf.ucw.cz>
References: <20051127161922.GM24446@sgala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051127161922.GM24446-QJaAV1IlLTQAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matteo Sgalaberni <sgala-QJaAV1IlLTQAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Ne 27-11-05 17:19:22, Matteo Sgalaberni wrote:
> Hello! I'm running debian sid on my asus M5636NBP.
> 
> Kernel 2.6.13.2 patched with Suspend2 2.2-rc7

Try vanilla 2.6.14.

> My fan it's always on.. only if I put the laptop outside with the 
> snow...when it' reach 20 celsius the fan stops...

Well, your trip_points say this is right behaviour. Why do you want to
change it.

> cat /proc/acpi/thermal_zone/THRM/trip_points
> critical (S5):           115 C
> passive:                 105 C: tc1=2 tc2=10 tsp=100 devices=0xc14706a0
> active[0]:               20 C: devices=0xc1477480
> 
> I tryed to change this settings echoing new values but no feedback by 
> the fan..

try echo -n "1:2:3:4:5" > trip_points.
								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
