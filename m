From: Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>
Subject: Re: fans not working after suspend to disk on nc-4000 and nc-8000
Date: Fri, 09 Sep 2005 12:41:27 +0200
Message-ID: <E1EDgJz-0000PH-00@dorka.pomaz.szeredi.hu>
References: <E1ECHiU-0005le-00@dorka.pomaz.szeredi.hu> <20050907183218.GA773@openzaurus.ucw.cz>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20050907183218.GA773-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org> (message from Pavel
	Machek on Wed, 7 Sep 2005 20:32:18 +0200)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: pavel-+ZI9xUNit7I@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > On the nc-4000 and nc-8000 notebooks, there's a problem with the fan
> > control after a resume from hiberantion.  This is a long standing
> > problem with an otherwise perfectly working hibernation.  Tried with
> > 2.6.10 to 2.6.13, and with suspend to disk and swsusp2.
> > 
> > After resume the fans are not switched on (or off) based on
> > temperature.  This is pretty dangerous, and makes hibernation
> > basically unusable for me.
> 
> acpi=off should solve it, too :-).

Yes, but that's rather noisy :)

> > Unloading the ACPI modules before suspend, and reloding them after
> > resume doesn't help.
> > 
> > Setting /proc/acpi/thermal_zone/TZ1/polling_frequency to some
> > value after resume _sometimes_ helps, but not reliably.
> 
> Does echo 0/3 > /proc/acpi/fan/*/state still work after resume?

Yes.

> Is kacpid looping after resume?

No.

> Is /proc/a*/thermal*/*/temperature still showing believable values?

Yes.  Perfectly normal.

> Does passive cooling work for you?

My guess not. /proc/acpi/thermal_zone/*/state does not change after
resume, except if polling is enabled.

I haven't left it long enough to see if it does work or not though.

> Can you send me your trip_points?

TZ1:

critical (S5):           102 C
passive:                 95 C: tc1=1 tc2=2 tsp=100 devices=0xdffcd468
active[0]:               67 C: devices=0xc14e89a8
active[1]:               60 C: devices=0xc14e8868
active[2]:               55 C: devices=0xc14e8768
active[3]:               40 C: devices=0xc14e8668

Normally this has some hysteresis, but after resume that doesn't
happen either (even if polling is enabled).

TZ2 and TZ3 are not actively cooled.

Does this info help?

Thanks,
Miklos


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
