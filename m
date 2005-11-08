From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: hard drive errors on acpi s3 resume
Date: Tue, 8 Nov 2005 10:30:41 +0100
Message-ID: <20051108093041.GI15730@elf.ucw.cz>
References: <59D45D057E9702469E5775CBB56411F1CDB8FB@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <59D45D057E9702469E5775CBB56411F1CDB8FB@pdsmsx406>
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
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >Please don't top post.
> >
> >> Just out of curiosity, what issues do you find with the coding
> >> style?
> >
> >I hope that means you want to clean it up and apply it ;-).
> >
> BTW, is this really worth submitting to upstream? It doesn't support
> _GTF. And it appears useless in my test systems.

My test systems work well enough without that. If there's a system
where it helps, I'd submit it.

[Could we loudly printk in not-yet-implemented _GTF to at least see
how many BIOSen need it? That could be good enough reason to apply it,
too.]

								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
