From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: standby problem
Date: Mon, 19 Sep 2005 10:32:05 +0200
Message-ID: <20050919083205.GH1893@elf.ucw.cz>
References: <59D45D057E9702469E5775CBB56411F171F9CF@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <59D45D057E9702469E5775CBB56411F171F9CF@pdsmsx406>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >> i wanted to know what's mean this error :)
> >>
> >> mrspurr:/home/giskard# echo standby > /sys/power/state
> >> acpi_pm_prepare does not support 1
> >>
> >> means that my laptop doesn't supporto standby mode?
> >
> >Probably yes.
> Is it possible we can just show available pm states in /sys/power/state?
> I think we should report the error earlier before we do actual
> suspend/resume. (maybe pm_ops should have a .supported_states callback
> for all archs) It seems many users are complaining about this after Len
> deprecated the proc interface.

Pavel Troller even had a patch, but it was too ugly. Yes, we should
only list available states in /sys/power/state.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
