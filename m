From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: acpi: sleep/proc.c cleanups
Date: Sat, 19 Mar 2005 23:31:15 +0100
Message-ID: <20050319223115.GC29495@message-id.gmane0305.slipkontur.de>
References: <20050319110657.GA1530@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319110657.GA1530-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

On Sat, Mar 19, 2005 at 12:06:57PM +0100, Pavel Machek wrote:

> --- clean/drivers/acpi/sleep/proc.c	2005-01-12 11:07:39.000000000 +0100
> +++ linux/drivers/acpi/sleep/proc.c	2005-01-12 11:20:13.000000000 +0100

> +		seq_printf(seq, "%4s	%4d		%s%8s\n",
> +			   dev->pnp.bus_id, (u32) dev->wakeup.sleep_state,
> +			   dev->wakeup.flags.run_wake ? "*" : "",
> +			   dev->wakeup.state.enabled ? "enabled" : "disabled");

Oh, now that i read this... :-)

What is the difference beteen "*enabled" and "enabled"? I noticed it today
when trying to get my Armada E500 to wake-on-lan from S3. So what is
wakeup.flags.run_wake?
-- 
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
