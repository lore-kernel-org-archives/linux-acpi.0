From: William Morgan <wmorgan-acpi-devel-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Subject: acpi on new gateway laptops
Date: Wed, 12 Nov 2003 18:23:15 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031112232315.GD430@masanjin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Casey Harkins <charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It looks like the Gateway support site contains nothing about the 200X
or 200XL models. Great. Do they support ACPI 1.0 or 2.0 or what? No
idea... I'm assuming ACPI 1.0.

I started looking at the ACPI spec. It contains two pages specifically
about the ECDT, pp128--129.

I don't quite understand the text of the first page:

  "This optional table provides the processor-relative, translated
  resources of an Embedded Controller. The presence of this table allows
  OSPM to provide Embedded Controller operation region space access
  before the namespace has been evaluated. If this table is not
  provided, the Embedded Controller region space will not be available
  until the Embedded Controller device in the AML namespace has been
  discovered and enumerated. The availability of the region space can be
  detected by providing a _REG method object underneath the Embedded
  Controller device."

(that's the entirety of it.)

It seems like having an ECDT is an optional feature? If that's so, then
what's the problem? Why isn't Linux simply "discovering and enumerating"
the "Embedded Controller device in the AML namespace"?

(BTW, it looks like ECDT actually stands for "Embedded Controller Boot
 Resources Table". Hm.)

The next page describes the contents of the table. Basically it involves
a bunch of deep hardware information, like "The bit assignment of the
SCI interrupt within the GPEx_STS register of a GPE block described in
the FADT that the embedded controller triggers."

It goes on to state that "ACPI 1.0 OSPM implementation will not
recognize or make use of the ECDT".

Shaohua Li said something that I didn't quite get either, in his first
response:

> The reason is BIOS of Gateway 400VTX lacks ECDT table.  And before
> initialize EC device, DSDT use ec space region when execute some ASL
> init methods. This will cause that battery can't be initializing.

So, what I *think* is happening, based on that, and on pp.203--204, is:

There's an Embedded Controller region (In the BIOS? In the DSDT?). One
cannot access a region until registering it, by calling
_REG(RegionSpace, 1). There's an exception to this, however, when using
an ECDT, which describes "controllers" (?) to access the Embedded
Controller region. If you have an ECDT you can then access this region
before registering it. So I think that's what the DSDT is doing, but
without providing an ECDT?

Re-examining the dmesg output, I *think* this makes sense.

So. This implies that rather than provide an ECDT, we can alternately
try and fix the DSDT. Since it's buggy anyways, that might conserve some
effort, and has the nice advantage of not forcing an upgrade to ACPI 2.0.
(Assuming I am ACPI 1.0 like you.)

I may send some of this to acpi-devel, if only to harass them.

-- 
William <wmorgan-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
