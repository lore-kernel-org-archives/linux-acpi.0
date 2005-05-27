From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH] ACPI build fix for 2.6.12-rc5
Date: Fri, 27 May 2005 08:27:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505270815330.17402@ppc970.osdl.org>
References: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
 <20050527085326.GA29767@toshiba.hsd1.ma.comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050527085326.GA29767-g3qfMnKXm6l/wjb6y0L7XlrsPObopucw0e7PPNI6Mm0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <lenb-g3qfMnKXm6l/wjb6y0L7XlrsPObopucw0e7PPNI6Mm0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexander Nyberg <alexn-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



On Fri, 27 May 2005, Len Brown wrote:
>
> Linus,
> Please apply this CONFIG_ACPI=n build fix to 2.6.12-rc5

Done.

Just a quick note about the Subject line, though (and this is not 
actually particular to Len at all, it's the second email on this that I 
send out just today ;)..

Since my automated tools will take the Subject line as the changelog
entry, and in fact it gets special treatment and ends up being in
shortlogs and in the gitweb summary pages etc, I like it when the Subject
line is "clean" in the sense that it makes sense in that context.

In particular, it's good for _me_ to know that a patch is against a
certain release (and not a "-mm" tree for example), so I certainly don't
mind seeing the the patch is for "2.6.12-rc5". But once it is in the tree,
that versioning information is pointless, and sometimes even wrong (ie
maybe I ended up actually applying the patch only after I released the
next kernel, and now that very public comment just looks strange).

So unless the version is literally important for the patch itself (ie, it 
might _be_ about the version numbers in the Makefile, and you send in a 
patch that changes the all-important NAME field of a particular release), 
I actually much prefer to see these "meta-comments" inside the [] in the 
Subject line, which automatically gets pruned off by the scripts.

IOW, something like this:

	[PATCH -rc5] ACPI build fix

works well (usually the major release is obvious, which is why I shorted 
it to just that part, but it's all up to you at that point: it will be 
peeled off and just replaced with [PATCH] by the scripts).

So in general, you can have small messages for the patch recipient in
there, but don't go overboard. If it's longer than twenty characters, it 
will usually mean that the _actual_ subject line may not show fully in my 
mail index, of course..

			Linus


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
