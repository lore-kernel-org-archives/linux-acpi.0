From: Neil Brown <neilb-YbfuJp6tym7X/JP9YwkgDA@public.gmane.org>
Subject: Re: Re: Reading /proc/acpi/battery/BAT0/info causes high latency on Dell Lattitude D800
Date: Tue, 29 Mar 2005 14:15:52 +1000
Message-ID: <16968.54904.300842.507973@cse.unsw.edu.au>
References: <3ACA40606221794F80A5670F0AF15F84041AC15F@pdsmsx403>
	<16965.56265.916668.235316@cse.unsw.edu.au>
	<20050328204534.GA28568@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: message from Stefan Seyfried on Monday March 28
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday March 28, seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org wrote:
> On Sun, Mar 27, 2005 at 08:01:45AM +1000, Neil Brown wrote:
> > On Saturday March 26, luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org wrote:
> > > Do you have this kind of problem before? Or just this kernel.
> 
> it started being this bad between 2.6.10-rc2-bk9 and 2.6.10-rc2-bk10.
> But only with CONFIG_ACPI_DEBUG

Oh.... (reconfig, recompile, reboot, retest).
Yes, you are right.  Drop ACPI_DEBUG and there is no noticeable pause
while reading /state or /info.

Thanks for that.

Still, it would be nice to have a proper fix.

If anyone wants to track this down and can suggest how I find out how
DEBUG is slowing things down so much, I'm happy to be a guinea pig.

NeilBrown


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
