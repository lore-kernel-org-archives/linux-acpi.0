From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Sat, 14 Sep 2002 17:09:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020914150932.GA10510@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0209071232170.1021-100000@cherise.pdx.osdl.net> <3D7C5FDF.4FB4E759@otello.alma.unibo.it> <20020913171338.GC7096@elf.ucw.cz> <200209141237.g8ECb2d03519@pfn1.pefnos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200209141237.g8ECb2d03519-a1J+ToZc0kR3t0M9ZKkFCQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > You bought new UPS for your server. How do you install it without
> > bringing machine down? Suspend to disk, rearrange power cables,
> > resume.
> >
> > You have your server on UPS. Power died, and UPS is indicating 30
> > seconds to failure. What do you do? Suspend to disk.
> >
> AFAIK there is already a 'low battery' line in 'inittab'. Following from that 
> point, we should use that line (for ACPI) instead of directly (from a binary) 
> trying to enter S4 or whatever. This way the root will chose how to handle 
> such a situation. In some machines S4 may be broken (not ACPI's fault always, 
> consider a mis-configured partition), there 'init 0' is the only safe way to 
> go down (see S5). Only the root of the machine may know that.
> This will certainly be a consideration point if we decide to implement (as a 
> de-facto standard) the runlevel.

Agreed, having it de-facto standard is very important. And inittab
looks like best solution.

> > Ethernet card in your server died. You want to replace it. Your
> > server is not hotplug capable. What do you do? Suspend to disk,
> > replace ethernet card, resume. If you are fast your users will not
> > even see broken connections.
> >
> Q. Will that really work?  Won't the change of Ethernet MAC ruin that?
> Anyway, everybody should be free to try that.

I was thinking ethernet card of some rarely used interface. Anyway MAC
is settable by software and even if you forget that ARPs should save
you.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
