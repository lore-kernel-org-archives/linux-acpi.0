From: "Edmund Rhudy" <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>
Subject: RE: Overheating is *not* dangerous Re: Changing temperature trip points
Date: Sun, 3 Nov 2002 17:46:57 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000601c2838a$e9dbb210$c200a8c0@pikachu>
References: <20021103223822.GN28704@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021103223822.GN28704-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Pavel Machek' <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: 'Dominik Brodowski' <linux-JhLEnvuH02M@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

So you're saying that if the hardware vendor screwed up, the end user
should suffer?  Are you entirely certain that this is an appropriate
view to take?

As for the Celeron, Intel lists the maximum junction temperature of the
4 different varieties of 900 MHz Celerons (the speed of the one in my
laptop) at either 72 C (in the case of the SL633) or 77 C (the SL5WY,
SL5MQ, SL5LX).

-----Original Message-----
From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org] 
Sent: Sunday, 3 November 2002 5:38 PM
To: Edmund Rhudy
Cc: 'Dominik Brodowski'; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: Overheating is *not* dangerous Re: [ACPI] Changing
temperature trip points


Hi!

> The point that I, and it would seem Dominik too, am trying to make is 
> that you can't always rely on this sort of stuff.  My laptop didn't 
> shut down when it was in danger, and it doesn't have any sort of 
> throttling

Your laptop is still alive, so I do not think it was in
danger. [Athlon/900 seems to work stable at 83Celsius. Celeron/300
worked stable up to 95Celsius. I do not know why you think 70Celsius is
too much for celeron].

> safeguard, nor is there anything that can be changed in the BIOS.  My 
> desktop allows you to set a shutdown temperature, but by default it's 
> left blank, so the system would happily slag itself unless there is 
> direct user intervention.  User intervention is not guaranteed, nor is

> a nicely behaved BIOS that watches for this sort of thing.

*If* fan on your desktop dies (1st hardware bug), and
your ACPI bios is broken (2nd hardware bug), and
you configure trip points but forget polling frequency (2 hw bugs and
user error), and 
your CPU does not have thermal protection (it has to according to ACPI
specs -- 3 hw bugs and user error) you can cook your cpu (given its
older athlon).

Okay but even if we compensated for your user error, still 3 hw bugs and
one software bug would cook your machine (kernel crash).

If hw vendor made 3 hardware errors... I guess he deserves to have that
machine cooked.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.





-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
