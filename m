From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Overheating is *not* dangerous Re: Changing temperature trip points
Date: Sun, 3 Nov 2002 23:38:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021103223822.GN28704@atrey.karlin.mff.cuni.cz>
References: <20021103221945.GH28704@atrey.karlin.mff.cuni.cz> <000501c28388$0b348f20$c200a8c0@pikachu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000501c28388$0b348f20$c200a8c0-3ycpsohRb2Y@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Edmund Rhudy <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>
Cc: 'Dominik Brodowski' <linux-JhLEnvuH02M@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> The point that I, and it would seem Dominik too, am trying to make is
> that you can't always rely on this sort of stuff.  My laptop didn't shut
> down when it was in danger, and it doesn't have any sort of
> throttling

Your laptop is still alive, so I do not think it was in
danger. [Athlon/900 seems to work stable at 83Celsius. Celeron/300
worked stable up to 95Celsius. I do not know why you think 70Celsius
is too much for celeron].

> safeguard, nor is there anything that can be changed in the BIOS.  My
> desktop allows you to set a shutdown temperature, but by default it's
> left blank, so the system would happily slag itself unless there is
> direct user intervention.  User intervention is not guaranteed, nor is a
> nicely behaved BIOS that watches for this sort of thing.

*If* fan on your desktop dies (1st hardware bug), and
your ACPI bios is broken (2nd hardware bug), and
you configure trip points but forget polling frequency (2 hw bugs and
user error), and 
your CPU does not have thermal protection (it has to according to ACPI
specs -- 3 hw bugs and user error)
you can cook your cpu (given its older athlon).

Okay but even if we compensated for your user error, still 3 hw bugs
and one software bug would cook your machine (kernel crash).

If hw vendor made 3 hardware errors... I guess he deserves to have
that machine cooked.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
