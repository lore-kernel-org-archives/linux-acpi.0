From: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Subject: Re: RE: ACPI -- Workaround for broken DSDT
Date: Thu, 05 Feb 2004 13:09:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4022326B.2020304@basmevissen.nl>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB6@hdsmsx402.hd.intel.com> <20040205082926.660974d2.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040205082926.660974d2.ak-l3A5Bk7waGM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andi Kleen wrote:


> I don't think that's completely true. A lot of the DSDTs I looked
> at had special cases for Win98,Win2000,WinXP. Undoubtedly the next
> windows versions will also require special cases in the AML.
> 
> Longer term all we can hope for is that the next generation of
> BIOS will also have a case for Linux.
> 

> A little bit more bug-to-bug compatibility surely couldn't hurt,
> even when Microsoft isn't even compatible to themsevles.
> 
> Like we already have the RELAXED_AML mode and everybody enables it ...
> It just isn't often relaxed enough.
> 

Yup, just emulate the latest version of bug-os :-)


Seriously, I think the only real solution is an independant 
qualification program. Vendors can then decide to add extra 
bug-compatibility for Win2k, WinXp and Linux too.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
