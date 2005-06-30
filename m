From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: AE_NO_MEMORY on ACPI init after memory upgrade and oops
Date: Thu, 30 Jun 2005 10:44:26 +0200
Message-ID: <20050630084426.GA30436@message-id.gmane0305.slipkontur.de>
References: <200506300042.22255.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200506300042.22255.fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fedor Karpelevitch <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 30, 2005 at 12:42:19AM -0700, Fedor Karpelevitch wrote:
> I tried to upgrade memory on my laptop from 2 x 128m by replacing one of the chips 
> with a 256m chip (these are PC2100 SODIMMS in case that matters). The new chip 
> appears to be fine - I do not see any memory corruptions or whatnot and I ran 
> memtest without any problems.
> 
> However there are two issues related to ACPI with this new chip (the problems
> go away when I replace it with the old one):
> 
> 1) when booting I get these error when "ec" module is being loaded:
> 
> Jun 23 23:25:28 bologoe kernel: [4294720.883000]     ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY

Did you override your DSDT?
-- 
Stefan Seyfried


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
