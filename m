From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI issues - suspend-to-ram and processor speed
Date: 20 May 2004 23:59:20 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085111960.12359.569.camel@dhcppc4>
References: <200405180213.34603.andre@eisenbach.com>
	 <40AC77A7.10704@eskuel.net>  <40ACF074.2090402@eisenbach.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40ACF074.2090402-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Cc: Mathieu LESNIAK <maverick-uEz9PMp7chasTnJN9+BGXg@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-05-20 at 13:52, Andre Eisenbach wrote:
> Mathieu LESNIAK wrote:
> 
> > Regarding the CPU slowdown, I've seen similar behaviour under Windows. 
> > I think it's related to the laptop itself, maybe as Pavel Machek said 
> > on LKML, it's the lack of power that force the laptop to run in this 
> > mode.
> 
> 
> According to the post on the LKML, the slowdown dows not occur in Linux 
> with ACPI=off.
> I do think that it may be a BIOS problem, but I hope that the ACPI 
> knowledgable may be able to provide a workaround.

could be a number of things.  Disabling the processor module would be
the workaround.

-Len




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
