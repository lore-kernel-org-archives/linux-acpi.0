From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [ACPI] RE: [ACPI-sppt] merge acpi-support into acpi-devel?
Date: Sat, 4 Oct 2003 18:59:40 +0100
Sender: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031004175940.GG24824@parcelfarce.linux.theplanet.co.uk>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC875A@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC875A-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-support>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi support <acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Oct 04, 2003 at 10:48:31AM -0400, Brown, Len wrote:
> The archive shows that overall, acpi-support gets 18% the traffic that acpi-devel gets.
> 
> There are newbie questions on LKML, and there is a FAQ to help them.
> I don't see why we shouldn't follow that model.
> 
> The down-side of 2 lists is that people who post to acpi-devel will
> probably get better support, so one wonders what is the advantage of
> having 2 lists.

Personally, I'm really not interested in any of the x86 shitty BIOS IRQ
routing type issues.  I'm interested in the following ACPI things:

 - It has to work on ia64 (that's my day job).
 - Solving some of the impedence mismatches between what ACPI expects
   and what the core kernel provides (eg the PCI config space accessing,
   down_timeout(), etc).
 - Refactoring the ACPI code to work better.

Not that I expect the lists to be arranged for my benefit, but would
anybody else be interested in a list-split along the lines of

 - acpi-x86 (for x86 specific problems)
 - acpi-core (for everything else)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
