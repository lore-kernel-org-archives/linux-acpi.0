From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [OT] 2.6.9: allow config to specify custom DSDT (Ulf
	Dambacher)
Date: 22 Oct 2004 00:14:03 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098418443.2096.8.camel@d845pe>
References: <3ACA40606221794F80A5670F0AF15F8403BD57CF@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD57CF@pdsmsx403>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Yi Zhu <yi.zhu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: brian-/bzczjCP1d2sTnJN9+BGXg@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

It has always been a mistake for SuSE to include that patch,
because an OSD can't possibly support modified OEM firmware.

DSDT overrides are for developers and experimentation,
not for production use.  Developers know how to build kernels,
and those that don't use initrd's can't use the initrd
method anyway.

The only argument for the initrd patch I've heard is from
somebody who deploys and supports the same kernel on
multiple systems, each with different DSDT patches.
I recommend that they choose their hardware vendor more
carefully in the future.

Also, the initrd pach isn't "clean" -- there isn't a supported
interface for appending junk onto an initrd, it is a hack to
do so with magic strings.

-Len
 
On Thu, 2004-10-21 at 23:20, Zhu, Yi wrote:
> Hi,
> 
> How about the DSDT_INITRD patch in SuSE kernel? I think it is cleaner
> than this one.
> What do you think?
> 
> Thanks,
> -yi
> 
> Len Brown wrote:
> > Note that CONFIG_ACPI_CUSTOM_DSDT depends on CONFIG_STANDALONE=n
> > 
> > The reason is that otherwise the allmodconfig and
> > allyesconfig builds break.
> > 
> > thanks,
> > -Len



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
