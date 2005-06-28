From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: CPU states
Date: Tue, 28 Jun 2005 07:39:21 +0200
Message-ID: <20050628053921.GA8678@isilmar.linta.de>
References: <42C0D199.1000708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42C0D199.1000708-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Petros Kolyvas <pkolyvas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Tue, Jun 28, 2005 at 12:27:05AM -0400, Petros Kolyvas wrote:
> Now that suspend to ram is functioning flawlessly (and I do mean 
> flawlessly - thanks good friends @ acpi-devel!), I'm looking, no 
> hunting, for information regarding cpu throttling under FC4/Linux. My 
> system, a 1.6GHz Pentium-M scales down, under FC4, to 600MHz. My 
> question or curiosity surrounds the fact that under windows, the cpu 
> speed can drop much lower than 600Mhz. Is this a limitation of current 
> software packages (or their states of development) or am I missing some 
> configuration information to take advantage of even lower power consumption.

You can lower the CPU frequency even below 600Mhz using throttling in
addition to CPU frequency scaling; however this won't give you any energy
saving at all in very most cases, but actually might even increase battery
usage, so I'd suggest not using it.

	Dominik


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
