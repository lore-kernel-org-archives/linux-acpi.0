From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 suspend code
Date: Wed, 30 Jul 2003 14:25:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030730122525.GA4224@openzaurus.ucw.cz>
References: <20030723162423.GD9013@atrey.karlin.mff.cuni.cz> <1059041888.19684.8.camel@bacchus.gpphy.uni-duesseldorf.de> <20030724104518.GA12041@paradigm.rfc822.org> <1059045536.19684.21.camel@bacchus.gpphy.uni-duesseldorf.de> <20030724144535.GA629@paradigm.rfc822.org> <20030724200411.GA444@elf.ucw.cz> <20030724204530.GA5907@laptop.6bone.nl> <20030724224141.GA430@elf.ucw.cz> <20030726234129.GA668@laptop.6bone.nl> <20030730082639.GD676@laptop.6bone.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030730082639.GD676-ScjxTogt4I4lGuH5DXb43w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mark Santcroos <marks-h3GR0owD+wQ@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > Like I said, the suspend returns immediately, but it does succeed.
> > > > It seems that it gets a wakeup signal immediately though. 
> > > 
> > > Like it turns into sleep mode then wakes up? You probably have some
> > > device that is enabled to wake the machine up, which should not really
> > > do that... Check 2.6.0-t1.
> > 
> > I've put a different disk in my laptop and installed Linux on it.
> > With 2.6.0-t1 it does the right thing. Also 2.5.75 works. 
> > I'm going do to a binary search to find the specific change that fixed it.
> 
> It looks like I had confused my earlier tests with something else, because
> also old Linux kernels do it "correctly".
> 
> My machine suspends as early as with 2.5.6 (the first kernel with
> /proc/acpi/sleep), note that it doesn't resume correctly up until 2.5.30 or 
> so, but that doesn't really matter.
> 
> Do you know if there is any way to find out what device or bus triggers
> the wakeup? A state stored somewhere or so.
> 

I do not know how to tell which device is that. Older kernels simply disabled all wakeups
altogether (that change should be easy to spot, it is somewhere really close to entering sleep),
which is wrong but worked for a lot of people. This change was taken/reverted few times, iirc.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
