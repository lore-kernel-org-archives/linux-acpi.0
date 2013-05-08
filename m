From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 2/2 v2, RFC] Driver core: Introduce offline/online
 callbacks for memory blocks
Date: Wed, 08 May 2013 08:38:11 -0600
Message-ID: <1368023891.30363.40.camel@misato.fc.hp.com>
References: <1576321.HU0tZ4cGWk@vostro.rjw.lan>
	 <1738385.YBsAESXG5F@vostro.rjw.lan>
	 <1367973454.30363.38.camel@misato.fc.hp.com>
	 <4229865.4cv6g5bbx4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <4229865.4cv6g5bbx4@vostro.rjw.lan>
Sender: owner-linux-mm@kvack.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, isimatu.yasuaki@jp.fujitsu.com, Len Brown <lenb@kernel.org>, linux-mm@kvack.org, wency@cn.fujitsu.com
List-Id: linux-acpi@vger.kernel.org

On Wed, 2013-05-08 at 13:53 +0200, Rafael J. Wysocki wrote:
> On Tuesday, May 07, 2013 06:37:34 PM Toshi Kani wrote:
> > On Wed, 2013-05-08 at 02:24 +0200, Rafael J. Wysocki wrote:
> > > On Tuesday, May 07, 2013 05:59:16 PM Toshi Kani wrote:

 :
 
> > > Moreover, it'd be better to do it in register_memory(), I think.
> > 
> > Yes, if we change register_memory() to have the arg state.
> 
> It can use mem->state which already has been populated at this point
> (and init_memory_block() is the only called).

Right.

> I've updated the patch to do that (appended).

Looks good!  Thanks for the update!
-Toshi




--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
