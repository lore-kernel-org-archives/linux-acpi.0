From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI on Dell Latitude C600
Date: Sat, 24 Jan 2004 18:35:38 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040124173538.GA300@elf.ucw.cz>
References: <003e01c3e040$ab873700$03f101a3@physics.ox.ac.uk> <20040123155820.GA194@elf.ucw.cz> <001c01c3e29c$e1f03fe0$03f101a3@physics.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <001c01c3e29c$e1f03fe0$03f101a3-JAjqph6Yjy8XSZKaUYBEcQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tim Stadelmann <t.stadelmann1-JAjqph6Yjy8XSZKaUYBEcQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Video issues with S3 resume
> >
> > ...
> >
> > You may have system where none of above works. At that point you
> > either invent another ugly hack that works, or write proper driver for
> > your video card (good luck getting docs :-(). Maybe suspending from X
> > (proper X, knowing your hardware, not XF68_FBcon) might have better
> > chance of working.
> 
> In other words, software suspend (which has its own problems, and is rather
> slow...) is the only chance of getting any kind of suspend mode to work
> under Linux on ACPI-only laptops in the forseeable future?

Yes, AFAICS.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
