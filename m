From: Greg Meyer <greg-AV60dr2H4Q3QT0dZR+AlfA@public.gmane.org>
Subject: Re: Where do I send APIC victims?
Date: Wed, 3 Sep 2003 09:19:51 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309030919.51807.greg@gkmweb.com>
References: <20030903080852.GA27649@k3.hellgate.ch> <200309031123.58713.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200309031123.58713.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Content-Disposition: inline
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

On Wednesday 03 September 2003 06:23 am, Andrew de Quincey wrote:
> On Wednesday 03 Sep 2003 9:08 am, Roger Luethi wrote:
> > As the maintainer of via-rhine, I get bug reports that almost in their
> > entirety are "fixed" by turning off APIC and/or ACPI. This has been going
> > on for several months now. Every now and then, something promising gets
> > posted on LKML, but so far if anything I've seen an _increase_ in those 
bug
> > reports. Maybe a fix is floating around and this will be a non-issue RSN. 
I
> > simply can't tell, since I don't have any IO-APIC hardware to play with.
> >
> > Instead of just telling everybody to turn off APIC, I'd like to point bug
> > reporters to the proper place and tell them what information they should
> > provide so it can get fixed for real. According to MAINTAINERS, Ingo 
Molnar
> > does Intel APIC, but the problems are with VIA chip sets. So where do I
> > send my users? Any takers?
> 
> Hi, I'm trying to develop patches for ACPI IRQ issues. 
> 
> Are these VIA KT333/KT400 chipsets? If so, there's a known bug in many 
BIOSes 
> with these chipsets. I'm waiting on some docs from VIA to fix this issue.
> 
I was just about to post that I have a Soyo KT-400 Dragon Ultra (black) with a 
integrated VIA Rhine II that has this problem.  I would really love to help 
solve this problem if I can.  I can provide any info you need as well as do 
some testing.



I have been using Mandrake, so I have been experiencing this because they have 
acpi turned on by default since a year (9.0).
-- 
Greg



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
