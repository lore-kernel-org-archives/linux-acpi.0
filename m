From: "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: standby problem
Date: Mon, 19 Sep 2005 07:32:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509190730570.27719@shark.he.net>
References: <59D45D057E9702469E5775CBB56411F171F9CF@pdsmsx406>
 <20050919083205.GH1893@elf.ucw.cz> <20050919084442.GA26295@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050919084442.GA26295-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 19 Sep 2005, Pavel Troller wrote:

> > Pavel Troller even had a patch, but it was too ugly. Yes, we should
> > only list available states in /sys/power/state.
> Hi!
>   I'm still using it but I don't know how to get the list of supported states
> otherwise than using my "ugly" ACPI-dependent method and without code
> duplication. Could You, Pavel, drop me some tips, I would then make the real
> patch and test it.
>                       With regards, Pavel Troller

The suggestion of a .supported_states callback seemed very
reasonable to me.  I've been working on something similar
to that in my free time, so between it and your patch (which
I'll find or you could repost it for review), we should be
able to make some progress.

-- 
~Randy


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
