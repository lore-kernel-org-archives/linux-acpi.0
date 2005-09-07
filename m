From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: fans not working after suspend to disk on nc-4000 and nc-8000
Date: Wed, 7 Sep 2005 20:32:18 +0200
Message-ID: <20050907183218.GA773@openzaurus.ucw.cz>
References: <E1ECHiU-0005le-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1ECHiU-0005le-00-VFwzv6uONVrxNFs70CDYszOMxtEWgIxa@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> On the nc-4000 and nc-8000 notebooks, there's a problem with the fan
> control after a resume from hiberantion.  This is a long standing
> problem with an otherwise perfectly working hibernation.  Tried with
> 2.6.10 to 2.6.13, and with suspend to disk and swsusp2.
> 
> After resume the fans are not switched on (or off) based on
> temperature.  This is pretty dangerous, and makes hibernation
> basically unusable for me.

acpi=off should solve it, too :-).


> Unloading the ACPI modules before suspend, and reloding them after
> resume doesn't help.
> 
> Setting /proc/acpi/thermal_zone/TZ1/polling_frequency to some
> value after resume _sometimes_ helps, but not reliably.

Does echo 0/3 > /proc/acpi/fan/*/state still work after resume? Is kacpid looping
after resume? Is /proc/a*/thermal*/*/temperature still showing
believable values?
Does passive cooling work for you? Can you send me your trip_points?

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
