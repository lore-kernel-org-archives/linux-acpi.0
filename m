From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH -mm] acpi: fix memory_hotplug externs
Date: Sat, 1 Apr 2006 16:08:18 -0800
Message-ID: <20060401160818.b9777586.rdunlap@xenotime.net>
References: <20060328114655.05e1933f.rdunlap@xenotime.net>
	<20060401221641.GC11800@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:19631 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932321AbWDBAGF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Apr 2006 19:06:05 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-acpi@vger.kernel.org>; Sat, 1 Apr 2006 16:06:02 -0800
In-Reply-To: <20060401221641.GC11800@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-acpi@vger.kernel.org

On Sun, 2 Apr 2006 00:16:41 +0200 Adrian Bunk wrote:

> On Tue, Mar 28, 2006 at 11:46:55AM -0800, Randy.Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Spell CONFIG option correctly so that externs work.
> > Fixes these warnings:
> > drivers/acpi/acpi_memhotplug.c:248: warning: implicit declaration of function 'add_memory'
> > drivers/acpi/acpi_memhotplug.c:312: warning: implicit declaration of function 'remove_memory'
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> >  linsrc/linux-2616-mm2/include/linux/memory_hotplug.h |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- rddunlap.orig/linsrc/linux-2616-mm2/include/linux/memory_hotplug.h
> > +++ rddunlap/linsrc/linux-2616-mm2/include/linux/memory_hotplug.h
> > @@ -105,7 +105,7 @@ static inline int __remove_pages(struct 
> >  }
> >  
> >  #if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_ACPI_HOTPLUG_MEMORY) \
> > -	|| defined(CONFIG_ACPI_MEMORY_HOTPLUG_MODULE)
> > +	|| defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)
> >  extern int add_memory(u64 start, u64 size);
> >  extern int remove_memory(u64 start, u64 size);
> >  #endif
> 
> What about simply offering the prototypes unconditionally?

duh, yes, that should be OK AFAIK.  Could you do that?

---
~Randy
