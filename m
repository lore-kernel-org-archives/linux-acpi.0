From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: PaceBlade broken acpi/memory map
Date: Tue, 25 Feb 2003 21:49:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030225204911.GK13404@poup.poupinou.org>
References: <20030220172144.GA15016@elf.ucw.cz> <20030224164209.GD13404@poup.poupinou.org> <20030224183955.GC517@atrey.karlin.mff.cuni.cz> <20030225143505.GH13404@poup.poupinou.org> <3E5B835E.7050601@symplon.com> <20030225151341.GI13404@poup.poupinou.org> <20030225174449.GD12028@atrey.karlin.mff.cuni.cz> <20030225200907.GJ13404@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030225200907.GJ13404-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Robert <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Robert Woerle <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 25, 2003 at 09:09:07PM +0100, Ducrot Bruno wrote:
> Hi Pavel,
> 
> On Tue, Feb 25, 2003 at 06:44:49PM +0100, Pavel Machek wrote:
> > 
> > I've received it after I made my patch, and I think that more machine
> > with broken tables will be created in future...
> > 
> 
> That it not the answer I expected.  To be more clear: you report errors
> on _STA and _INI.  I don't know why.  But with my previous patch, it seems
> that there is no such errors (but it is with 2.4).
> And one of the suspect(s) for what I know is your mem= option patch.

Ok.  Found your patch in LKML.  Soon like to be OK.  Will see then what
hapens, but I need your dmesg.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
