From: Petr Vandrovec <vandrove-hnqZr3NxcozrBKCeMvbIDA@public.gmane.org>
Subject: Re: [PATCH] bad strlcpy conversion breaks toshiba_acpi
Date: Fri, 25 Jul 2003 18:15:10 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030725161510.GA31565@vana.vc.cvut.cz>
References: <3F2142CE.4090608@prairienet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F2142CE.4090608-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
To: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Cc: Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Michael Wawrzyniak <gan-28sE0Wxkf/LCXR85Y8Hu3Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 25, 2003 at 10:46:38AM -0400, John Belmonte wrote:
> Please revert the following item from Ben Collins' "drivers/* strlcpy 
> conversions" patch dated 2003-May-26.
> 
> The strlcpy function requires a zero-terminated string, which is not a 
> valid assumption for the code in question.  I suggest that Ben review 
> all such modifications he made to the kernel for similar errors.  It's 
> quite annoying to have someone add bugs to your driver while you're not 
> looking.  Either notify the maintainer of your patch or don't make mistakes.

Nope. Kernel strlcpy implementation is crap and I do not believe that there
is single place in the kernel which can live with current implementation. 

Take a look at ftp://ftp.openbsd.org/pub/OpenBSD/src/lib/libc/string/strlcpy.c 
or at http://www.courtesan.com/todd/papers/strlcpy.html - it copies
at most size-1 characters. Nothing about characters beyond specified size 
in the article.

Kernel should use strnlen() to get string length, if coding loop like
OpenBSD does is unacceptable.
						Best regards,
							Petr Vandrovec
