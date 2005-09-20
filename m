From: "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: standby problem
Date: Mon, 19 Sep 2005 21:09:36 -0700
Message-ID: <20050919210936.4cd0c3b7.rdunlap@xenotime.net>
References: <59D45D057E9702469E5775CBB56411F171FA38@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <59D45D057E9702469E5775CBB56411F171FA38@pdsmsx406>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: pavel-AlSwsSmVLrQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 19 Sep 2005 17:00:25 +0800 Li, Shaohua wrote:

> Hi,
> >
> >> >> i wanted to know what's mean this error :)
> >> >>
> >> >> mrspurr:/home/giskard# echo standby > /sys/power/state
> >> >> acpi_pm_prepare does not support 1
> >> >>
> >> >> means that my laptop doesn't supporto standby mode?
> >> >
> >> >Probably yes.
> >> Is it possible we can just show available pm states in
> /sys/power/state?
> >> I think we should report the error earlier before we do actual
> >> suspend/resume. (maybe pm_ops should have a .supported_states
> callback
> >> for all archs) It seems many users are complaining about this after
> Len
> >> deprecated the proc interface.
> >
> >Pavel Troller even had a patch, but it was too ugly. Yes, we should
> >only list available states in /sys/power/state.
> Ok, how does this one look? Each arch provides a .valid callback.

With this patch, I see in /sys/power/state either:
standby disk		# if CONFIG_SOFTWARE_SUSPEND=y

or just:
standby			# if CONFIG_SOFTWARE_SUSPEND=n

Does this mean that my poor old BIOS cannot do STR or did I miss
a config option?  Yes, I have CONFIG_ACPI_SLEEP=y.
Is there another config option for STR?

I think it would be great if we could make the config options
something more user-friendly, like Suspend to Disk and
Standby/Suspend to RAM.  Or at least mention Suspend to RAM
in the Help text....  It would also make sense (from a user's
perspective) to have them together (next to each other).

---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
