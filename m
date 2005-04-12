From: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Subject: Policy question (was Re: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop)
Date: Mon, 11 Apr 2005 20:09:28 -0400
Message-ID: <200504112009.30928.rob@landley.net>
References: <20050406212221.75716.qmail@web88010.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050406212221.75716.qmail-PllgjHOHifKB9c0Qi4KiSl5cfvJIxWXgQQ4Iyu8u01E@public.gmane.org>
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
To: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 06 April 2005 05:22 pm, Shawn Starr wrote:
> --- Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> > Hi!
> >
> > > So nobody minds if I make this into a CONFIG
> >
> > option marked as Deprecated? :)
> >
> > Actually it should probably go through
> >
> > Documentation/feature-removal-schedule.txt
> >
> > ...and give it *long* timeout, since it is API
> > change.
> > 									Pavel

Shouldn't all deprecated features be in feature-removal-schedule.txt?

There are four entries in feature-removal-schedule in 2.6.12-rc2, but
`find . -name "Kconfig" | xargs grep -i deprecated` finds eight entries.  (And 
there's more if the grep -i is for "obsolete" instead...)

Just wondering...

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
