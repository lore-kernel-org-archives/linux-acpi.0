From: "Thomas Herrmann" <ollo.diab-Mmb7MZpHnFY@public.gmane.org>
Subject: RE: Re: K7 & cpu disconnect
Date: Thu, 22 Jan 2004 13:09:06 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7629.1074773346@www13.gmx.net>
References: <F760B14C9561B941B89469F59BA3A8470255EFEF@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > Hi Len,
> > 
> > one more data point wrt this topic.
> > I can enable STPGNT/CPU disconnect on my NForce2 system 
> > running WinXP while
> > using the tool from http://www.hasw.net/8rdavcore. And guess 
> > what, the system
> > runs stable for hours, not locking-up at all. Since this is 
> > exactly the same
> > hardware as well as BIOS configuration, it leads me to 
> > beleave the Linux
> > ACPI/IO_APIC implementation has an issue.
> 
> If the ACPI/IO APIC code has a problem, you should be able to cause the
> problem while not enabling the out-of-spec feature. I think you should
> feel free to run whatever stress test you can think of, but if the fault
> only occurs when you are out of spec, then in my opinion it is asking a
> lot to ask people to devote time towards fixing it.
> 
> Regards -- Andy
> 
Hi Andy,

is this realy an out-of-spec feature? I mean STPGNT is documented by AMD and
the K7 Barton Core does requests it as a platform/BIOS option.

I just wanted to make aware of an (potential) timing issue in the interrupt
response mechanism of the current ACPI/IO_APIC implementation. The patches
Ross Dickson has posted on the LKML due support this IMHO. Might be it occures
in different scenarios too. Maybe not today, maybe in the future ,who knows.

I'm not asking for a personal favor here. I think you guys have done a great
job getting interrupt routing working fine on the NForce2 & SiS740 platform.

Regards,    Thomas

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Bis 31.1.: TopMail + Digicam für nur 29 EUR http://www.gmx.net/topmail



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
