From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: high pitch noise with kernel 2.6 and ACPI (Dell Inspiron
 8200)
Date: Wed, 18 Feb 2004 14:11:32 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040218140940.K36847@root.org>
References: <200402181320.29381.mailinglists@glomann.de>
 <1077111155.2028.3.camel@personal-118.mip.sdu.dk> <200402182017.47960.mailinglists@glomann.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200402182017.47960.mailinglists-WoYc4IhrKEiELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Glomann <mailinglists-WoYc4IhrKEiELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 18 Feb 2004, Thomas Glomann wrote:
> On Wednesday 18 February 2004 14:32, Mads Paulin wrote:
> > Hi Thomas,
> >
> > funny you mention it, I thought I was going crazy.
> >
> > I experienced the same thing, and discovered it to be the hard drive.
> >
> > Try to spind the drive down using hdparm and see if that helps.
> >
> nope, putting the drive to sleep doesn't do the trick. the sound remains.
> Moreover I don't see how this "solution" was meant to work? Does the sound
> reappear when you wake up your disk or does it keep silent after a nice
> "onetime" sleep?
> > Obviously this is not a solution, but if it helps, kernel 2.6 could have
> > some other way of controlling the disk than 2.4.
> >
> Still it doesn't explain why that sound is gone when disabling the whole
> acpi-system.
> > The noise disappears when my hdd is under heavy load.
> > - Maybe you just cant here it then, or it actually disappears because it
> > is no longer idle
> >
> well thats true. as long as the disk is Not idle, the noise is gone. But
> returns right after.

Disable cpu idling support or try various combinations of C1-C3.  The
noise is most likely capacitors (dis)charging as part of chipset-supported
clock stopping.  You can detect this case by changing the scheduling
quantum (HZ) to be something other than 1000.

-Nate


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
