From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Thinkpad T40 Fan
Date: Wed, 4 Feb 2004 21:44:14 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB5@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ben lamothe <blamothe-DPNOqEs/LNQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>> This behavior is not exibited in Windows,
>> on the contrary, the fan is almost never on.

> ACPI can't control fan in many IBM systems,
> including T40. DSDT of T40 has no fan device defined.

Hmm, how can Windows keep the fan off but Linux can't?

As there is no ACPI fan device, there must be a different method to
control the fan on this box.

1. It may be some i2c device that Windows knows about but Linux does
not?
   Maybe IBM ships some platform specific software with windows?
   Would be interesting to know if a from-scratch install of the
   generic non-IBM windows was still able to keep the fan off.

2. It may be some BIOS code using SMM that Linux somehow breaks?

3. It may be done entirely in hardware without the knowledge of the OS?

I'm hopeful that it is #3, and that Windows is simply doing better
passive cooling than Linux -- and perhaps we can perhaps improve our
passive cooling...

Can you run some experiments?  Maybe you can monitor the temperature in
windows to see if it really is cooler.  Perhaps you can experiment with
the power management policy settings such that it is in high-power mode
instead of maximum battery mode and observe the temperature rises, and
at what temperature the fan starts running?

Thanks,
-Len


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
