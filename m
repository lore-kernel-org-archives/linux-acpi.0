From: Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Compaq Evo N160: Fixed DSDT - battstat_applet works now
Date: 24 Dec 2002 12:36:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <87of7bd4y2.fsf@lapper.ihatent.com>
References: <3DFB6C25.4030805@gmx.net> <200212201958.53205@-mixdown.ca>
	<3E049608.8030807@gmx.net> <200212211352.42773@-mixdown.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200212211352.42773-T9p8nP5vHr8sA/PxXw9srA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Kohlsmith <akohlsmith-acpi-uiYP0llB1AZBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew Kohlsmith <akohlsmith-acpi-uiYP0llB1AZBDgjK7y7TUQ@public.gmane.org> writes:

> > One question arose during the last days: What is the "last full
> > capacity" of your battery? Is it near 4000 mAh as specified by Compaq?
> 
> I've currently see 3357mAh in the "last full capacity" -- I too patched 
> klaptopdaemon to use this value instead of the design capacity since I'd only 
> ever get as high as 98%, which suggests 3920mAh was seen at some point.  :-)
> 
> > I'm not really satisfied with this "solution" either, as "my" value of
> > 3357 mAh probably is only correct for my special Evo n160 (or to be more
> > precise: my one's battery) at a special time.
> 
> Exactly -- I just patched klaptopdaemon to keep the highest "last full 
> capacity" as a high-water mark (but it isn't persistent).
> 

While on Compaq Evo's and batteries... I've got a n800c, and when it
was new (this summer) it would run a normal length of work on
batteries under XP (more than 2 hours), these days it will charge the
battery and claim it to be full and the windows batt-stat-applet will
say I've got an hour left. In real the machine will not survive 20
minutes on battery.

Having a think back, this all started to go down the drain at the same
time I started experimenting with Linux and ACPI. Is there any way
that the ACPI bits in the linux-kernels could have messed with the
battery in such a way?

I've ran mostly 2.4.x with acpi patches applied; although
/proc/acpi/battery always remians emtpy.

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
