From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: 2.5.69 - S3
Date: Sun, 18 May 2003 12:48:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030518104852.GA324@elf.ucw.cz>
References: <200305140140.02188.mflt1@micrologica.com.hk> <20030516111120.GA686@zaurus.ucw.cz> <200305180523.25157.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200305180523.25157.mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Was playing a bit with S3 - Single user mode, console, ACPI core
> > > only, no modules.
> > >
> > > Suspending always works.
> > >
> > > Resuming performs somewhat randomly as follows:
> > >
> > > 1) Linux! - hang
> > >
> > > 2) Resume failed
> > >
> > > 3) Resumes with lots of shell prompts scrolling, and seems to be
> > > functional thereafter
> > >
> > > What is the expected behaviour at this time?
> >
> > 3) is expected. You held down enter
> > when you did echo, so it still sees
> > enter down after resume.
> 
> Thank you,  a script which delays a few seconds before suspend should fix 3)
> 
> How to get rid of 1) and 2) ?

For 4) (harddisk problems from other mail): does it work after IDE
reset? If not, try disabling DMA with hdparm.

As for 1) and 2): Good luck debugging 1) [adding more letters to see
where it hangs etc]; what exactly means 2)?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
