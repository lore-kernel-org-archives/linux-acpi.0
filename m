From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: Tree for December 20 (acpi_video)
Date: Wed, 26 Jan 2011 12:42:03 +0100
Message-ID: <20110126114203.GA16754@elte.hu>
References: <20101220200013.df8fbc88.sfr@canb.auug.org.au>
 <20101220085340.7ba098b9.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101220085340.7ba098b9.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <lenb@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Luming Yu <luming.yu@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Randy Dunlap <randy.dunlap@oracle.com> wrote:

> On Mon, 20 Dec 2010 20:00:13 +1100 Stephen Rothwell wrote:
> 
> > Hi all,
> > 
> > [The mirroring on kernel.org is running slowly]
> > 
> > Changes since 20101217:
> 
> 
> ERROR: "thermal_cooling_device_register" [drivers/acpi/video.ko] undefined!
> ERROR: "thermal_cooling_device_unregister" [drivers/acpi/video.ko] undefined!

This bug has been reported two months ago, one month ago, it has been ignored twice 
and now the bug has been pushed upstream and it's triggering there as well.

What's going on?

Thanks,

	Ingo
