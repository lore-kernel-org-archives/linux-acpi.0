From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: acpi: sleep/proc.c cleanups
Date: Thu, 31 Mar 2005 16:27:25 +0200
Message-ID: <20050331142724.GA609@openzaurus.ucw.cz>
References: <20050319110657.GA1530@elf.ucw.cz> <20050319223115.GC29495@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050319223115.GC29495-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
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

Hi!

> > --- clean/drivers/acpi/sleep/proc.c	2005-01-12 11:07:39.000000000 +0100
> > +++ linux/drivers/acpi/sleep/proc.c	2005-01-12 11:20:13.000000000 +0100
> 
> > +		seq_printf(seq, "%4s	%4d		%s%8s\n",
> > +			   dev->pnp.bus_id, (u32) dev->wakeup.sleep_state,
> > +			   dev->wakeup.flags.run_wake ? "*" : "",
> > +			   dev->wakeup.state.enabled ? "enabled" : "disabled");
> 
> Oh, now that i read this... :-)
> 
> What is the difference beteen "*enabled" and "enabled"? I noticed it today
> when trying to get my Armada E500 to wake-on-lan from S3. So what is
> wakeup.flags.run_wake?

Not quite sure, probably something to do with runtime wakeups :-).
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
