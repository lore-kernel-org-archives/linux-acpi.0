From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: [OT] 2.6.9: allow config to specify custom DSDT (Ulf Dambacher)
Date: Fri, 29 Oct 2004 18:39:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041029163918.GH5387@message-id.gmane0305.slipkontur.de>
References: <3ACA40606221794F80A5670F0AF15F8403BD57CF@pdsmsx403> <1098418443.2096.8.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1098418443.2096.8.camel@d845pe>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 22, 2004 at 12:14:03AM -0400, Len Brown wrote:
> It has always been a mistake for SuSE to include that patch,
> because an OSD can't possibly support modified OEM firmware.

Well, you know, there are also basically "unsupported" SUSE
releases, namely the box products. And there it is nice to
be able to override the DSDT with a simple "mk_initrd" without
having to recompile the Kernel _and_ all additional drivers.
You know, the nice 3d drivers or the wireless drivers or...

Of course the customer is on its own if he is running with
a patched DSDT, but he is also on his own if he is _not_ but
then with a non-working machine.

> Also, the initrd pach isn't "clean" -- there isn't a supported
> interface for appending junk onto an initrd, it is a hack to
> do so with magic strings.

This is something one could change if there was an agreement on
how to do it right and "clean".
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
