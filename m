From: "Edmund Rhudy" <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>
Subject: RE: Overheating is *not* dangerous Re: Changing temperature trip points
Date: Sun, 3 Nov 2002 17:26:24 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000501c28388$0b348f20$c200a8c0@pikachu>
References: <20021103221945.GH28704@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021103221945.GH28704-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Pavel Machek' <pavel-+ZI9xUNit7I@public.gmane.org>, 'Dominik Brodowski' <linux-JhLEnvuH02M@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The point that I, and it would seem Dominik too, am trying to make is
that you can't always rely on this sort of stuff.  My laptop didn't shut
down when it was in danger, and it doesn't have any sort of throttling
safeguard, nor is there anything that can be changed in the BIOS.  My
desktop allows you to set a shutdown temperature, but by default it's
left blank, so the system would happily slag itself unless there is
direct user intervention.  User intervention is not guaranteed, nor is a
nicely behaved BIOS that watches for this sort of thing.

-----Original Message-----
From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org] 
Sent: Sunday, 3 November 2002 5:20 PM
To: Dominik Brodowski
Cc: Edmund Rhudy; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Overheating is *not* dangerous Re: [ACPI] Changing temperature
trip points


Hi!

> > Actually, Documentation/acpi/processor.txt seems like right place. 
> > "Polling" warning should be in Documentation/, really.
> 
> Which does not exist ==> extremely dangerous situation. Even though 
> you should know what you're doing when you meddle with the affairs of 
> kernels, kernels should try at least to some extent to be safe to use.

So perhaps its good time to create Documentation/acpi? ;-).

Anyway it is not *dangerous* situation. ACPI machines power down on
overtemp.
								Pavel,
who forced his toshiba satellite to 95Celsius CPU temp to see how it
behaves, and who has hp omnibook xe3 with broken cpu fan and 900mhz
athlon. Yes I have seen emergency shutdowns many time already.

[BTW toshiba is designed properly, and even without fan is able to
passively cool itself by going from 300MHz to 40Mhz. Omnibook is broken
and its thermal throttling is not capable of keeping CPU cool enough.
What is worse, in some cases omnibook cpu makes harddisk hot (while cpu
is in limit and machine does not do emergency poweroff), leading to bad
things (tm).]

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.





-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
