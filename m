From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: S3 resume on Omnibook XE3-GF
Date: Fri, 2 Aug 2002 10:31:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020802083149.GC12868@atrey.karlin.mff.cuni.cz>
References: <20020729110018.GC835@atrey.karlin.mff.cuni.cz> <000001c239aa$effc2d20$0201010a@cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000001c239aa$effc2d20$0201010a-39LOpZwlz18NEHC595MGIQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: "'ACPI List (E-mail)'" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Sorry for the delay in replying.
> 
> I misread your email at first, and also checked S1. After a brief
> post-resume inspection, I can say that everything seems to work well there -
> the display is turned back on and the hard drive powers back up.
> 
> Regarding S3, since the display doesn't come back on I needed to do echo -e
> "\a", but otherwise followed your instructions. I get a much longer delay
> and a much longer beep, so I reckon your theory is bang-on.

I checked yesterday, and delays look okay for me after S3.

However, you probably need to solve display problem first... And I'm
not sure how to debug that.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
