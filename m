From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: 2.6.10 acpi patch
Date: 06 Jan 2005 15:02:46 -0500
Message-ID: <1105041766.18175.1290.camel@d845pe>
References: <41DD908A.1000907@sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41DD908A.1000907-Mv9iWk4wWl8RDxlzMovjVg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexander Zubkov <green-Mv9iWk4wWl8RDxlzMovjVg@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-01-06 at 14:24, Alexander Zubkov wrote:

> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.10/
>  there is some strange files for final release of the 2.6.10 kernel, 
> which contains no patch - only some comments. Is it OK?

right now the early 2.6.11 tree is still called 2.6.10
in the source, so my 2.6.11 patch (which is empty)
over-wrote the 2.6.10 patch. [actually it isn't totally
empty, it reflects that i back-ported linus' video.c
slab corruption cset to 2.6.10, but as that was already
in 2.6.11 the comments appear w/o any code chage.

for some reason linus refuses to update the Makefile
when he opens a new release -- benh brought this up
on lkml back at the end of 2.6.9.  Many resolutions
were proposed, but no action was taken.

i'll go ahead and push the 2.6.10 pach from the 26-stable-release
tree into the 2.6.10 directory.  Of course this is a no-win
situation because until the release makefile is updated,
there are two patchs that want to have the same name...

-Len



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
