From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: kern 2.6.1 - suspend/resume still malfunctioning
Date: Sun, 18 Jan 2004 19:37:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040118183744.GB215@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8401720CEA@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CEA-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > all the data, i reported about my laptop is recorded with bug #1773
> > > http://bugme.osdl.org/show_bug.cgi?id=1773
> > 
> > have you tried S4, e.g. "echo 4 > /proc/acpi/sleep"?
> > S3 is probably harder to get working than S4, so try S4 first.
> 
> Why?  

Video issues: [Actually, if intel would want to help with these... it
would be great. You need to solve it for Itaniums, anyway...]


								Pavel

                Video issues with S3 resume
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~
                     2003, Pavel Machek

During S3 resume, hardware needs to be reinitialized. For most
devices, this is easy, and kernel driver knows how to do
it. Unfortunately there's one exception: video card. Those are usually
initialized by BIOS, and kernel does not have enough information to
boot video card. (Kernel usually does not even contain video card
driver -- vesafb and vgacon are widely used).

This is not problem for swsusp, because during swsusp resume, BIOS is
run normally so video card is normally initialized.

There are three types of systems where video works after S3 resume:

* systems where video state is preserved over S3. (HP Omnibook xe3)

* systems that initialize video card into vga text mode and where BIOS
  works well enough to be able to set video mode. Use
  acpi_sleep=s3_mode on these. (Toshiba 4030cdt)

* systems where it is possible to call video bios during S3
  resume. Unfortunately, it is not correct to call video BIOS at that
  point, but it happens to work on some machines. Use
  acpi_sleep=s3_bios (Athlon64 desktop system)

Now, if you pass acpi_sleep=something, and it does not work with your
bios, you'll get hard crash during resume. Be carefull.

You may have system where none of above works. At that point you
either invent another ugly hack that works, or write proper driver for
your video card (good luck getting docs :-(). Maybe suspending from X
(proper X, knowing your hardware, not XF68_FBcon) might have better
chance of working.

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
