From: David G Hamblen <dave-RfZrpLcwWZ/QT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: Battery status reading problems
Date: Fri, 26 Sep 2003 08:25:47 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0309260758340.1211-100000@puppy.afrinc.com>
References: <20030926085542.GA28731@hout.vanvergehaald.nl>
Reply-To: dave-wr1Qx4d9ef7QT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030926085542.GA28731-UrA3525iEjFfB9KAG+eifygtU7bT7/Jf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Toon van der Pas <toon-UrA3525iEjFfB9KAG+eifygtU7bT7/Jf@public.gmane.org>
Cc: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 26 Sep 2003, Toon van der Pas wrote:

> On Thu, Sep 25, 2003 at 10:38:57PM -0700, Jan Rychter wrote:
> >
> > For the reference, I have always had performance problems with reading
> > the battery status on my Sharp Mebius. I can't use any "battery applets"
> > nor cpufreqd because of that -- they eat too much CPU power and cause
> > the whole machine to slow down.
> >
> > I got bored with reporting this all over again, and since this issue has
> > been largely ignored by developers, I decided I can do without battery
> > information after all.
>
> My Dell Inspiron 8100 gives me the same problems.
> I didn't really check wether Windows shows the same problems.
> I don't use Windows much.  :-)
>
> Regards,
> Toon.

Same with my Dell 8100: under 2.6.0-test3 (acpi), the gnome panel battery
capplet uses 23% of the CPU and 2.7% of the memory while the wmacpi
program uses only 2.6% of the CPU and .4% of the memory.

With the same kernel compiled for apm rather than acpi, bath the battstat
capplet usage and the wmapm usage drop to 0.0%.

Sounds like an ACPI (software?) problem to me.

Dave



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
