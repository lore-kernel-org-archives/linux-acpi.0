From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 won't resume correctly
Date: Wed, 19 Feb 2003 11:32:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030219103234.GE23503@atrey.karlin.mff.cuni.cz>
References: <20030218224905.GB8829@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030218224905.GB8829-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I'm using an Asus L3800C laptop, which itself is quite ACPI-compatible
> (well, all is ok except for trivial things like C3 not supported for the
> P4-M processor). I've been testing the S3 status since 2.5.59, up to
> 2.5.61. I use XFS for my root filesystem, which makes it inconvenient to
> suspend (at least for 2.5.x, there are appropriate patches for 2.4.20), but
> the problem I experience is not fs-related, i guess.
> 
> The system suspends correctly (though issuing some warnings about pagebufd
> not stopping, which as I told is XFS specific), even the power LED blinks
> accordingly to the manual, indicating S3. However, upon resume neither the
> display, nor the keyboard works. Appending acpi_sleep=s3_bios fixes the
> display, but the keyboard still won't respond. I am able to ssh to the box
> after resume and everything except the keyboard seems to work fine
> then.

Well, that's not that bad, all you need is an driver support for
keyboard to kick it back to live ;-). You might want to setleds +num
or something like that.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
