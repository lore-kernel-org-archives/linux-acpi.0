From: Andries Brouwer <aebr-ek1Qb6IBo2Pz+pZb47iToQ@public.gmane.org>
Subject: Re: [PATCH] bad strlcpy conversion breaks toshiba_acpi
Date: Fri, 25 Jul 2003 18:57:09 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030725165709.GA670@win.tue.nl>
References: <3F2142CE.4090608@prairienet.org> <20030725161510.GA31565@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030725161510.GA31565-Kr4v8scruuLwY2GEPTd/bA@public.gmane.org>
To: Petr Vandrovec <vandrove-hnqZr3NxcozrBKCeMvbIDA@public.gmane.org>
Cc: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>, Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Michael Wawrzyniak <gan-28sE0Wxkf/LCXR85Y8Hu3Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 25, 2003 at 06:15:10PM +0200, Petr Vandrovec wrote:

> Nope. Kernel strlcpy implementation is crap and I do not believe that there
> is single place in the kernel which can live with current implementation. 
> 
> Take a look at ftp://ftp.openbsd.org/pub/OpenBSD/src/lib/libc/string/strlcpy.c 
> or at http://www.courtesan.com/todd/papers/strlcpy.html - it copies
> at most size-1 characters. Nothing about characters beyond specified size 
> in the article.
> 
> Kernel should use strnlen() to get string length, if coding loop like
> OpenBSD does is unacceptable.

strlcpy is for strings, not for character arrays.
The *BSD version accesses the source past the size-1 characters that are copied:
	while (*s++)
		;
Thus, replacing strncpy (used to copy character arrays, possibly not 0-terminated)
by strlcpy is wrong.
