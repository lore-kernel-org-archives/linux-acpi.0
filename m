From: randy_dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Some generall questions...
Date: Fri, 15 Jul 2005 14:19:04 -0700
Message-ID: <20050715141904.56bc2ea7.rdunlap@xenotime.net>
References: <42D81E3F.7060507@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42D81E3F.7060507-cGBD8117FJM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 15 Jul 2005 22:36:15 +0200 Janosch Machowinski wrote:

> Hey,
> I got 2 questions :
> First, are we supporting some architecture, that does not support the 
> hlt instruction ??

No idea.

> And the second one, is it diswanted to write comments in the kernel 
> source, or are most programmers just to lazy to do it ?

a.  we don't want comments for obvious language constructs, e.g.,
don't do this:

	err_count++;		/* increment the error count */

b.  it seems to be a challenge sometimes to get good comments and to
keep comments and code synchronized.  :(
But comments are generally a good thing, so that someone can understand
the intent of some code or how it's accomplished, if it's tricky.
And when adding new globally-visible functions, please use the
kerneldoc format for them (see linux/Documentation/kernel-doc-nano-HOWTO.txt).

---
~Randy


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
