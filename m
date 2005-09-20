From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: standby problem
Date: Tue, 20 Sep 2005 11:44:43 +0200
Message-ID: <20050920094443.GC20380@elf.ucw.cz>
References: <59D45D057E9702469E5775CBB56411F171FA38@pdsmsx406> <20050919210936.4cd0c3b7.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050919210936.4cd0c3b7.rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > >Pavel Troller even had a patch, but it was too ugly. Yes, we should
> > >only list available states in /sys/power/state.
> > Ok, how does this one look? Each arch provides a .valid callback.
> 
> With this patch, I see in /sys/power/state either:
> standby disk		# if CONFIG_SOFTWARE_SUSPEND=y
> 
> or just:
> standby			# if CONFIG_SOFTWARE_SUSPEND=n
> 
> Does this mean that my poor old BIOS cannot do STR or did I miss
> a config option?  Yes, I have CONFIG_ACPI_SLEEP=y.
> Is there another config option for STR?

I think its your poor old BIOS/hardware. 

> I think it would be great if we could make the config options
> something more user-friendly, like Suspend to Disk and
> Standby/Suspend to RAM.  Or at least mention Suspend to RAM
> in the Help text....  It would also make sense (from a user's
> perspective) to have them together (next to each other).

I guess patches are accepted.. but be warned: SWSUSP is generic
option, while ACPI_SLEEP is ... well, ACPI related.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
