From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: fans not working after suspend to disk on nc-4000 and nc-8000
Date: Sat, 10 Sep 2005 23:55:53 +0200
Message-ID: <20050910215552.GA2463@openzaurus.ucw.cz>
References: <E1ECHiU-0005le-00@dorka.pomaz.szeredi.hu> <20050907183218.GA773@openzaurus.ucw.cz> <E1EDgJz-0000PH-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1EDgJz-0000PH-00-VFwzv6uONVrxNFs70CDYszOMxtEWgIxa@public.gmane.org>
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
Cc: pavel-+ZI9xUNit7I@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Unloading the ACPI modules before suspend, and reloding them after
> > > resume doesn't help.
> > > 
> > > Setting /proc/acpi/thermal_zone/TZ1/polling_frequency to some
> > > value after resume _sometimes_ helps, but not reliably.
> > 
> > Does echo 0/3 > /proc/acpi/fan/*/state still work after resume?
> 
> Yes.
> 
> > Is kacpid looping after resume?
> 
> No.
> 
> > Is /proc/a*/thermal*/*/temperature still showing believable values?
> 
> Yes.  Perfectly normal.

Okay, so ACPI is basically okay, but fan driver is confused.
You need to add code to handle suspend and resume into fan.c.
Probably force everything on for suspend, and sync it with
software expectations after resume.


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
