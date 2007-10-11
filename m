From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/6] PNP: use dev_info(), dev_err(), etc in core
Date: Wed, 10 Oct 2007 22:47:39 -0700
Message-ID: <20071010224739.f4ecd5aa.akpm@linux-foundation.org>
References: <20070928163911.697537922@ldl.fc.hp.com>
	<20070928164350.079891622@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48036 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752989AbXJKFr7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Oct 2007 01:47:59 -0400
In-Reply-To: <20070928164350.079891622@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

On Fri, 28 Sep 2007 10:39:14 -0600 Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> --- w.orig/include/linux/pnp.h	2007-09-13 16:25:48.000000000 -0600
> +++ w/include/linux/pnp.h	2007-09-13 16:26:04.000000000 -0600
> @@ -8,6 +8,10 @@
>  
>  #ifdef __KERNEL__
>  
> +#ifdef CONFIG_PNP_DEBUG
> +#define DEBUG
> +#endif

In file included from include/linux/isapnp.h:26,
                 from drivers/pcmcia/i82365.c:58:
include/linux/pnp.h:12:1: warning: "DEBUG" redefined
<command line>:1:1: warning: this is the location of the previous definition

testing problems?
