From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Re: AE_NO_MEMORY on ACPI init after memory upgrade and oops
Date: Thu, 30 Jun 2005 21:49:54 +0200
Message-ID: <20050630194954.GA20844@message-id.s3e.de>
References: <200506300042.22255.fedor@karpelevitch.net> <20050630084426.GA30436@message-id.gmane0305.slipkontur.de> <200506300618.15109.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200506300618.15109.fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 30, 2005 at 06:18:13AM -0700, Fedor Karpelevitch wrote:
> Stefan Seyfried wrote:
> > On Thu, Jun 30, 2005 at 12:42:19AM -0700, Fedor Karpelevitch wrote:
> > > I tried to upgrade memory on my laptop from 2 x 128m by replacing

> > Did you override your DSDT?
> 
> Yes, I did.

So you need to modify your _new_ _original_ DSDT again after the memory
upgrade.
AFAIK the DSDT contains numbers that depend on the amount of memory and
is often built dynamically by the BIOS => even changing some BIOS settings
may change the DSDT.
-- 
Stefan Seyfried


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
