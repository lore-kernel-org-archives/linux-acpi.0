From: William Morgan <wmorgan-acpi-devel-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: acpi on new gateway laptops
Date: Wed, 12 Nov 2003 18:33:28 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031112233328.GE430@masanjin.net>
References: <20031112232315.GD430@masanjin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031112232315.GD430-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
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

Heh. Didn't mean to hit send quite so fast. :)

For context, the two threads are:
http://sourceforge.net/mailarchive/message.php?msg_id=6229363 and
http://sourceforge.net/mailarchive/message.php?msg_id=6319180

In both cases /proc/battery is empty and it has been suggested that we
are missing an ECDT table and should (somehow) provide one.

For those in the know about ACPI, comments would be greatly appreciated
on these two issues:

First:

 [According to the ACPI spec] It seems like having an ECDT is an
 optional feature? If that's so, then what's the problem? Why isn't
 Linux simply "discovering and enumerating" the "Embedded Controller
 device in the AML namespace"?

Second, does this scenario make any sense:

 There's an Embedded Controller region (In the BIOS? In the DSDT?). One
 cannot access a region until registering it, by calling
 _REG(RegionSpace, 1). There's an exception to this, however, when using
 an ECDT, which describes "controllers" (?) to access the Embedded
 Controller region. If you have an ECDT you can then access this region
 before registering it. So I think that's what the DSDT is doing, but
 without providing an ECDT?

Third, would this solution work?

 Rather than provide an ECDT, we can alternately try and fix the DSDT.
 Since it's buggy anyways, that might conserve some effort, and has the
 nice advantage of not forcing an upgrade to ACPI 2.0.

Sorry for all the clutter. My thanks in advance.

-- 
William


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
