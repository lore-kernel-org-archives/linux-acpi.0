From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: hard drive errors on acpi s3 resume
Date: Wed, 09 Nov 2005 08:57:04 +0800
Message-ID: <1131497825.2998.6.camel@linux-hp.sh.intel.com>
References: <59D45D057E9702469E5775CBB56411F1CDB8FB@pdsmsx406>
	 <20051108093041.GI15730@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051108093041.GI15730-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-11-08 at 10:30 +0100, Pavel Machek wrote:
> Hi!
> 
> > >Please don't top post.
> > >
> > >> Just out of curiosity, what issues do you find with the coding
> > >> style?
> > >
> > >I hope that means you want to clean it up and apply it ;-).
> > >
> > BTW, is this really worth submitting to upstream? It doesn't support
> > _GTF. And it appears useless in my test systems.
> 
> My test systems work well enough without that. If there's a system
> where it helps, I'd submit it.
> 
> [Could we loudly printk in not-yet-implemented _GTF to at least see
> how many BIOSen need it? That could be good enough reason to apply it,
> too.]
I guess I should clean it up and let people in bugzilla try. If there
are success stories, I'll report back.

Thanks,
Shaohua 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
