From: Peter Meier <crazy-b-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: b44 -- Re: No network after S3
Date: Thu, 26 Feb 2004 16:50:23 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077810622.5332.54.camel@homer>
References: <BF1FE1855350A0479097B3A0D2A80EE0025A6344@hdsmsx402.hd.intel.com>
	 <1077000806.2515.46.camel@dhcppc4> <200402170856.42059.t.zachmann@zagge.de>
	 <200402240741.30530.t.zachmann@zagge.de>  <1077640877.5369.12.camel@homer>
	 <1077660024.3036.56.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1077660024.3036.56.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, pp-YuCZbdju05vHOG6cAo2yLw@public.gmane.org, davem-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> It would be interesting to know if you can unload the driver before
> going to S3, and then load it after resuming from S3.  ie. can the b44
> hardware survive the S3 transition if it is quiescent?

No, that does not help. The same error message.

> > Kernel is 2.6.3-mm3; I have IO-APIC enabled. cat /proc/interrupts
> > gives
> > me the idea that the network card uses PIC.
> 
> system will be in XT-PIC mode or IO-APIC mode -- can't be both.  I
> assume that /proc/interrupts shows this device receiving no interrupts
> after the S3 resume?

Yeah, /proc/interrupts shows XT-PIC mode.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
