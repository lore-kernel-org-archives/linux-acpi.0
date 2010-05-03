From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PNP: don't check for conflicts with bridge windows
Date: Mon, 3 May 2010 09:53:05 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005030950530.5478@i5.linux-foundation.org>
References: <20100503164647.308.86063.stgit@bob.kio> <20100503164721.308.11075.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53766 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750933Ab0ECQyg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 May 2010 12:54:36 -0400
In-Reply-To: <20100503164721.308.11075.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Pavel Kysilka <goldenfish@linuxsoft.cz>, Adam Belay <abelay@mit.edu>, Jaroslav Kysela <perex@perex.cz>



On Mon, 3 May 2010, Bjorn Helgaas wrote:
>  			if (tres->flags & IORESOURCE_IO) {
>  				if (cannot_compare(tres->flags))
>  					continue;
> +				if (tres->flags & IORESOURCE_WINDOW)
> +					continue;
>  				tport = &tres->start;
>  				tend = &tres->end;
>  				if (ranged_conflict(port, end, tport, tend))
> @@ -271,6 +273,8 @@ int pnp_check_mem(struct pnp_dev *dev, struct resource *res)
>  			if (tres->flags & IORESOURCE_MEM) {
>  				if (cannot_compare(tres->flags))
>  					continue;
> +				if (tres->flags & IORESOURCE_WINDOW)
> +					continue;

Hmm. Looking at the patch, I am wondering if it wouldn't make _more_ sense 
to instead say that you never mix IORESOURCE_WINDOW with 
IORESOURCE_IO/MEM? That would make the above patch unnecessary, since it 
would never trigger the test for IORESOURCE_IO/MEM in the first place.

A resource window is a window - it's not the resource itself. It's not IO 
or MEM - that could/should be an attribute of what resource _tree_ the 
window is linked into, not the resource itself.

Hmm?

		Linus
