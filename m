From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI using smp_processor_id in preemptible code
Date: Tue, 11 Jan 2005 09:04:34 +0800
Message-ID: <1105405464.18834.4.camel@sli10-desk.sh.intel.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575F05409@pdsmsx402.ccr.corp.intel.com>
	 <20050110095508.GJ1353@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050110095508.GJ1353-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-01-10 at 17:55, Pavel Machek wrote:
> > >I enabled CPU hotplug and preemptible debugging... now I get...
> > >
> > >BUG: using smp_processor_id() in preemptible [00000001] code:
> > >swapper/0
> > >caller is acpi_processor_idle+0xb/0x235
> > > [<c020ba28>] smp_processor_id+0xa8/0xc0
> > > [<c02338ce>] acpi_processor_idle+0xb/0x235
> > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > [<c02338ce>] acpi_processor_idle+0xb/0x235
> > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > [<c02338c3>] acpi_processor_idle+0x0/0x235
> > > [<c0101115>] cpu_idle+0x75/0x110
> > > [<c04f5988>] start_kernel+0x158/0x180
> > > [<c04f5390>] unknown_bootoption+0x0/0x1e0
> > It doesn't trouble to me. It's in idle thread.
> 
> You mean it does not happen to you? On my machine it fills logs very
> quickly...
What I mean is idle thread can't be migrated so this doesn't impact the
correctness. I guess the preemptible debugging can't recognise such
situation.

Thanks,
Shaohua



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
