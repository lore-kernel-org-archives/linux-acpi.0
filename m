From: ross-iWlVPHNiaoT2fBVCVOL8/A@public.gmane.org
Subject: ACPI Suspend on Inspiron 1100
Date: Thu, 31 Mar 2005 14:19:32 -0500
Message-ID: <20050331191931.GA16450@jose.lug.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello everyone,

I have some questions on ACPI suspend on a Dell Inspiron 1100.  I have
tried two different kernels: 2.6.8 (as comes with Debian sarge) and a
2.6.11.6 (which I built myself).  This is with BIOS A31.

Neither one has working ACPI suspend, though the symptoms are different:

1) 2.6.8: putting the machine to sleep via proc/sysfs works, but the
laptop immediately wakes back up.  It looks almost like some device is
not going to sleep, generating activity, and then causing a wakeup.

2) 2.6.11.6: putting the machine to sleep via proc/sysfs works, but
the machine never fully wakes up.  I can still login to a console and
halt the laptop, but the display won't turn back on.  Switching
to/from X11 VT doesn't seem to help.

It behaves this way for all suspend/sleep types except disk, which
does nothing (as I kind of expected, and is OK).  I've dumped the
DSDT, disassembled and recompiled.  No errors are produce, just a few
warnings - mostly about invalid return types.

I'd like to get this working.  Is is likely?  Should I fix the DSDT
warnings?  My understanding is that they won't make a big difference.
Any help is much appreciated!

-- 
Ross Vandegrift
ross-iWlVPHNiaoT2fBVCVOL8/A@public.gmane.org

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
