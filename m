From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: [ANNOUNCE] acpi4asus 0.27 released
Date: Thu, 29 Jan 2004 17:54:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040129165457.GA25252@hell.org.pl>
References: <20040128224812.GA27820@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040128224812.GA27820-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Karol Kozimor:
[...]

The 0.27 release is making its way to sourceforge.net, but you can grab it
here in the meanwhile:

http://hell.org.pl/~sziwan/asus/acpi4asus-0.27.tar.bz2

ChangeLog says:
Version 0.27
        Added support for L8400L
        Kill off WLED for xxN, it is controlled by the driver
        Added support for S5200N
        Add support for 2.6 external module compilation (without kbuild)
        Add L3H / L2E LCD switching support
        Fix 100% cpu bug in asus_acpid when acpid is restarted
        Fix LED handling and clean it up
        Remove L5C's WLED support, since it has never worked
        Add ASYM, another value for userspace
        Update asus_acpid to follow acpid defaults
        Added support for TLED
        Added helper functions for LED and proc entries (thx Pontus)
        Added support for M1300A
        Use C99 initializers (Pontus Fuchs)
        Properly support M2400N
        /proc/acpi/asus/?led handling fix (thanks to Robert Vollmert)
        Properly support L3H and L2000E

Thanks for all the support,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
