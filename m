From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI on Dell Latitude C600
Date: Fri, 23 Jan 2004 16:58:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040123155820.GA194@elf.ucw.cz>
References: <003e01c3e040$ab873700$03f101a3@physics.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <003e01c3e040$ab873700$03f101a3-JAjqph6Yjy8XSZKaUYBEcQ@public.gmane.org>
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

> I've recently experimented with getting ACPI sleep states to work on my Dell
> Latitude C600 (BIOS revision A21) using a 2.6.0 kernel and the latest
> appropriate patch from acpi4linux.
> 
> With a minimal amount of kernel driver modules loaded, both S1 and S3 almost
> work, with one interesting problem:
> 
> The computer displays messages indicating it is going into the appropriate
> sleep state, then switches off most peripherals *except* for the screen and
> backlight.  Pressing the power button causes it to resume, but now the
> screen is switched *off* during this process.  Changing the virtual console
> to the one used for X11 causes the X server to switch the screen back on and
> the computer appears to be working properly afterwards.


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

* systems where video state is preserved over S3. (Athlon HP Omnibook xe3s)


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
