From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] s3_bios and lcall $0xc000,$3
Date: Tue, 18 Feb 2003 00:55:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030217235512.GA7372@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.33.0302171423290.21415-100000@godzilla.axis.se> <Pine.LNX.4.33.0302171647410.21415-100000@godzilla.axis.se> <20030217171610.GC25625@poup.poupinou.org> <1045505626.5596.20.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1045505626.5596.20.camel-udXHSmD1qAz9bBlWBkG5g4WQyAnV0byH@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Pavel, really, we need to provide a better way to reinitialize
> > the VGA subsystem.
> 
> And you need to make no assumptions about the state - on an i830 (and
> others, no doubt), S4 == S5 for the video subsystem.

Are we talking swsusp here? No, subject says S3. So you have typo
there?

Anyway going without assumptions is pretty hard, as it requires
in-kernel support for all the video cards. And that's hard. [Power-on
initialization of cards is different; you have to setup memory timings
etc.]
 
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
