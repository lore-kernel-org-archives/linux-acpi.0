From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Tue, 28 Dec 2004 10:12:07 +0800
Message-ID: <1104199926.21206.9.camel@sli10-desk.sh.intel.com>
References: <200412271318.32251.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412271318.32251.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>, Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-12-27 at 20:18, stefandoesinger-RbZlAiThDcE@public.gmane.org wrote:
> > This patch is quite interesting. If you just move '
> > acpi_leave_sleep_state(acpi_state)' to acpi_pm_leave, what's the
> result?
> > And please send me a copy of your acpidmp, I'd like look at it.
> Works too with 2.6.10. Strange, AFAIK this didn't work with 2.6.7.
> I sent the output of acpidump in a private mail(File fize)
Your original patch (move 'acpi_leave_sleep_state' and
'acpi_disable_wakeup_device' to 'acpi_pm_leave') seems safer (in case
resumed devices generate unexpected wakeup interrupts), please submit a
patch to Len.

Though I wonder if 'acpi_pm_leave' should be called before
'device_power_up' (ACPI spec said _WAK should be called before device
resume, which possibly includes system devices). There isn't a
straightforward fix for this, acpi_leave_sleep_state is designed being
called with interrupt enabled. But anyway, we can fix it till we
actually find one real bug.

Thanks,
Shaohua



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
