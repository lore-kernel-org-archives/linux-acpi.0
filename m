From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Fri, 6 Aug 2004 15:58:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040806135828.GB30727@wotan.suse.de>
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

On Fri, Aug 06, 2004 at 08:13:25AM +0200, ole.rohne-vJEk5272eHo@public.gmane.org wrote:
> Len> I would like a solution that applies to x86_64 in addition to
> Len> i386.
> 
> What would it take?
> 
> I know absolutely nothing about that architecture. From
> arch/x86_64/kernel/acpi/wakeup.S it seems to support some form of real
> mode, so could it do the return to real mode just like i386?

x86-64 S3 wakeups works exactly the same as i386, it just switches 
to long mode instead of 32bit mode. x86-64 has real mode too
(it is a fully compatible PC with an additional 64bit long mode) 

The code is slightly different for historical reasons, but 
if you have real mode POST code you can probably just insert
it into the real mode part of the x86-64 S3 wakeup.

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
