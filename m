From: Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>
Subject: Re: Re: PROBLEM: ACPI freezes 2.6.1 on boot
Date: Thu, 22 Jan 2004 14:59:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16399.55109.244040.516731@alkaid.it.uu.se>
References: <7F740D512C7C1046AB53446D3720017361885C@scsmsx402.sc.intel.com>
	<m3u12pgfpr.fsf@reason.gnu-hamburg>
	<m3ptddgckg.fsf@reason.gnu-hamburg>
	<20040122120854.GB3534@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040122120854.GB3534-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>, "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Martin Loschwitz <madkiss-R0iKqZn4BxJAfugRpC6u6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Karol Kozimor writes:
 > Thus wrote Georg C. F. Greve:
 > > So the problem we've been seeing seems to be related to the
 > > interaction between local APIC support and ACPI.
 > 
 > We've definitely had those problems before (with ASUS L3800C), there's 
 > even a patch fixing this issue (attached below) you might try.
 > I guess that's another of those lost and forgotten bugzilla bugs :)
 > 
 > -- 
 > Karol 'sziwan' Kozimor
 > sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
 > 
 > 
 > diff -Bru linux-2.6.0-test8/arch/i386/kernel/apic.c patched/arch/i386/kernel/apic.c
 > --- linux-2.6.0-test8/arch/i386/kernel/apic.c	2003-10-18 05:43:36.000000000 +0800
 > +++ patched/arch/i386/kernel/apic.c	2003-10-30 23:17:50.000000000 +0800
 > @@ -836,8 +836,8 @@
 >  {
 >  	unsigned int lvtt1_value, tmp_value;
 >  
 > -	lvtt1_value = SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV) |
 > -			APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
 > +	lvtt1_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
 > +
 >  	apic_write_around(APIC_LVTT, lvtt1_value);

What is the purpose of this change?
I don't remember seeing this before on LKML. (I don't have time to read bugzilla.)


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
