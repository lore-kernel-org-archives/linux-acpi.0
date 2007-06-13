From: Andi Drebes <lists-receive@programmierforen.de>
Subject: Re: [KJ] [PATCH] drivers/acpi: sizeof/sizeof array size calculations replaced with ARRAY_SIZE
Date: Wed, 13 Jun 2007 23:21:38 +0200
Message-ID: <200706132321.39440.lists-receive@programmierforen.de>
References: <200705261239.27485.lists-receive@programmierforen.de> <200706122041.06252.lists-receive@programmierforen.de> <200706121253.07395.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server001.webpack.hosteurope.de ([80.237.130.9]:42655 "EHLO
	server001.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751448AbXFMVWK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2007 17:22:10 -0400
In-Reply-To: <200706121253.07395.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@infradead.org>, Len Brown <lenb@kernel.org>, kernel-janitors@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

<snip>
> You found the right one.  The ACPI CA in Linux is really the same
> as the one from Intel.  Len integrates the Intel one into Linux
> periodically.  He uses scripts or something to format it so it looks
> more like Linux.
Ok. That's what I thought so far.

> I think Len sometimes takes patches against the "Linux-ized" ACPI CA.
> He probably has to apply those by hand to the Intel one, which is
> the real "upstream" in this case.  So it might be a bit easier for
> him if you generated a diff against the Intel version. 
OK. I will do this in the next time.

> In any event, you want to end up with one patch, not two.
Ok. I thought of two patches because I didn't know how strong
the sources from the  ACPI CA are modified.

> You probably would have to add something like:
> 
>   #ifndef ARRAY_SIZE
>   #define ARRAY_SIZE(x) ...
>   #endif
> 
> somewhere in the ACPI CA header files.  That way it will work in
> non-Linux OSes as well.

Thanks so far,
	Andi
