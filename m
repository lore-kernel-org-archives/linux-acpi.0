From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Changing temperature trip points
Date: Sun, 3 Nov 2002 23:22:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021103222222.GJ28704@atrey.karlin.mff.cuni.cz>
References: <20021103220251.GC28704@atrey.karlin.mff.cuni.cz> <000301c28385$b68eb510$c200a8c0@pikachu> <20021103221143.GF28704@atrey.karlin.mff.cuni.cz> <20021103231846.D19750@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021103231846.D19750-JhLEnvuH02M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Cc: Edmund Rhudy <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > My point is more that it might be better to assume that things won't
> > > work.  This isn't a sound driver.  This is something that the life of
> > > the computer depends on, and if somebody's processor melts down because
> > > they didn't read some piece of kernel documentation that they didn't
> > > even know existed, they're not likely to be particularly forgiving and
> > > think "Oh, it was my fault for not realising that my hardware was
> > > broken, I'll be more careful next time".
> > 
> > No. Worst that can happen is that your machine powers off. And thats
> > after machine already has at least one hardware bug.
> 
> Actually, I doubt that it will power off. Assume your BIOS vendor set
> critical to 110°C (my vendor did so). And the CPU burns through at 70°C.
> Let's assume no thermal management objects like fans exist. Without custom
> polling, a trip point of 65°C for critical has no, really no effect. The
> CPU melts down. Or am I missing something?

Yes, you are missing reality.

Try stopping your fan and see what happens. I believe you'll see your
notebook powering off itself at <90C, low enough to keep cpu alive.

									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
