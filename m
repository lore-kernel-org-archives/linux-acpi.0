From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Wed, 11 Aug 2004 21:39:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040811193933.GG1120@openzaurus.ucw.cz>
References: <20040730141028.GE21359@luna.mooo.com> <20040730162756.4f300a5c@localhost> <20040730190047.GH21359@luna.mooo.com> <1091560208.24759.15.camel@6-allhosts> <41103952.2030707@optonline.net> <1091583216.2974.2.camel@localhost.localdomain> <1091590835.2304.64.camel@dhcppc4> <yzohdrjqu6p.fsf@localhost.localdomain> <1091631174.2297.90.camel@dhcppc4> <yzosmb0hjzu.fsf@pb-d-128-141-40-189.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <yzosmb0hjzu.fsf-1zyhLZfD728Z/JH0GhYu5ApX6sy8U9uuH79+75y5D5U@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ole.rohne-vJEk5272eHo@public.gmane.org
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Acpi Devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Erik Tews <erik-KVSZC2aA8+zw/snApU8qRLNAH6kLmebB@public.gmane.org>, Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Len> I would like a solution that applies to x86_64 in addition to
> Len> i386.
> 
> What would it take?

Len, you can't expect ole to write x86-64 support without testing.
Patch should be designed so that it does no damage on non-i386, but
you should not expect more.

It would be nice if i386 version could be merged. I'll probably do
x86-64 in future; stable i386 version
would certainly help me.

> I know absolutely nothing about that architecture. From
> arch/x86_64/kernel/acpi/wakeup.S it seems to support some form of real
> mode, so could it do the return to real mode just like i386?

Yes.

> "lkml" - is that the linux kernel mailing list? 
Yes.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
