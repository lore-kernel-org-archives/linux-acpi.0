From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: 2.5.34?
Date: Tue, 17 Sep 2002 15:49:15 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020917154914.E39@toy.ucw.cz>
References: <willy@debian.org> <200209161130.g8GBUo024143@p2.parker.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200209161130.g8GBUo024143-paYRYfI9b/YMuHHiPFXXZ1fOaUvyCJUZ@public.gmane.org>; from brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org on Mon, Sep 16, 2002 at 07:30:50AM -0400
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Gustavo Sverzut Barbieri <gsbarbieri-/E1597aS9LRfJ/NunPodnw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Can anyone provide a coherent description of the S3 support in 2.5.34?
> Is it close?  does it need patches (like the one above?)

It worked before. IDE support is recommended, through.

> I'm willing to put some work into it but I'd benefit from whom ever is
> closest to it giving a quick status.
> 
> It seems like if S4 can be made to work, S3 should be straightforward
> (heh).  If tried it in a stock 2.5.34 and found no difference from the
> 2.2.x acpi patched kernels I use...

S3 is not as simple as you think, but as it worked before... It should
be easy.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
