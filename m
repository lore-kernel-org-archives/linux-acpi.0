From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: [Fwd: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume
 on Centrino notebook (contains agp, lapic, swsusp)]
Date: Tue, 10 Feb 2004 21:53:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3k72uwtaf.fsf@reason.gnu-hamburg>
References: <1076374686.3429.1.camel@darkstar>
	<m3oes76x8l.fsf@brain.gnuhh.org> <20040210194816.GD12634@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040210194816.GD12634-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> (Dave Jones's message of
 "Tue, 10 Feb 2004 19:48:16 +0000")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

 || On Tue, 10 Feb 2004 19:48:16 +0000
 || Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote: 

 >> The moment I enable AGP (no DRM/DRI, no intel fb), things break.

 dj> If you have DRI & FB disabled, AGP isn't going to get used.  It's
 dj> just dead code.  For this reason, I find it hard to believe its
 dj> causing a problem.

So was I... but empirical evidence pointed towards it.

Maybe it was a false positive created by the PCMCIA (yenta) stuff,
which seems flakey wrt to ACPI/suspend/resume, but that is unlikely.

I am fairly confident that AGP breaks powermanagement for most
Centrino notebooks, in particular the 855GM ones.

Btw: Does anyone plan to pick this up anytime soon?

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
