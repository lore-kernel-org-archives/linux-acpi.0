From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI patch flow
Date: Tue, 3 Feb 2004 13:28:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040203122832.GA1405@elf.ucw.cz>
References: <1075747579.2394.108.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1075747579.2394.108.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> In an effort to make sure the latest ACPI patch is widely available, I
> currently publish it both as bk trees and plain patches
> http://linux-acpi.bkbits.net/
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
> 
> against 7 releases:
> 
> 2.4.22
> 2.4.23
> 2.4.24
> 2.4.25
> 
> 2.6.0
> 2.6.1
> 2.6.2
> 
> I'd like to stop maintaining (and delete) 2.4.23 -- with the release of
> 2.4.24, I doubt anybody is using 2.4.23.
> 
> I'd like to stop maintaining (and delete) 2.6.0 -- with the release of
> 2.6.1, I doubt anybody is using 2.6.0.  Also, 2.6.1 has diverged
> somewhat from 2.6.0, so maintaining 2.6.0 has become problematic.
> 
> let me know if you have any issues with this.

I do not see any problems with that.

For 2.6, if I were you, I'd drop 2.6.1, too. People should upgrade to
latest if they have problems..

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
