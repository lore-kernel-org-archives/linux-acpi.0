From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: CONFIG_PM, CONFIG_ACPI, CONFIG_ACPI_SLEEP
Date: Thu, 10 Mar 2005 01:00:16 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3002F22F98@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>-----Original Message-----
>From: Nigel Cunningham [mailto:ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org]=20

>I think 'everybody' is an overstatement. If I put things in the wrong
>place such that I break CONFIG_PM=3Dn, I hear about it. That said, I do
>agree that CONFIG_PM=3Dy can increasingly be taken for granted.

I linux there is somebody someplace using every possible configuration
-- if it makes sense or not.  So the strategy is to delete the
configurations that don't make much sense so we don't get sidetracked
into supporting things that are unimportant to nearly all users.

>Perhaps there's an issue somewhere else though. After all, I'd be
>surprised if you argued that CONFIG_ACPI_FAN was a power management
>function.

Actually, the fan is definitely a power management function -- think
active/passive cooling, power zones, cpu speeds etc.

But there are other "run time" ACPI functions that are not technically
power management, such as hot plug support.

> Maybe ACPI config options could be split up a little so that
>those related to PM did come under CONFIG_PM, and those related to PNP
>or whatever else could appear elsewhere? Of course I'm speaking as
>someone who doesn't know exactly how closely all of this functionality
>inter-relates, so what makes sense to me might not make sense to you :>

We used to sort of try to do this, but it turned out to be a bad idea.
The ACPI interpreter is required for configuration, so deleting power
management doesn't save you much.  The power management policy drivers
(like fan) are individually configurable, so you can Y/N/M them
independently.

Today the only ACPI thing that depends on PM is the ACPI sleep code.
But sleep and poweroff are very similar, and we'd like to be able to
count on some PM functionality for poweroff in ACPI mode.

thanks,
-Len


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
