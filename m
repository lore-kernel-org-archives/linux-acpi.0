From: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: compile problem
Date: Mon, 26 May 2003 18:13:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030526181327.21984b10.nils@kernelconcepts.de>
References: <3ED1E212.30108@ottaky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ED1E212.30108-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 26 May 2003 09:44:50 +0000
sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org> wrote:
> Apologies for this not being a strictly ACPI problem.

It looks so, yes.

> I'm trying to compile an ACPI enabled kernel for my Vaio. I've tried 
> numerous combinations of kernel sources and patches as per the
> pointers from members of this list.
> 
> However, I always get this error during "make modules_install"
> 
> Not being a seasoned kernel builder, I really don't know what's wrong 
> and I was wondering if anybody here can tell me what's up.

The problem you are seein is that symbols of the built modules do not
resolve to kernel symbols. This can have several reasons. One simple one
is that those modules indeed reference something that isn't there
(anymore).
The second one is that your build symbol tables have become confused.
This may happen when patching kernel and/or modifying the kernel
configuration. This can be resolved by doing (inside the toplevel kernel
directory):
	mv .config ..
	make mrproper
	mv ../.config .
	make oldconfig
	make dep
	make bzImage modules modules_install

This helped me several times ;)

And last but not least the brute force method... unless you need those
modules, simply remove them from /lib/modules/* :)

> TIA
> sjb
CU
  nils

> cd /lib/modules/2.4.20; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
> pcmcia if [ -r System.map ]; then /sbin/depmod -ae -F System.map 
> 2.4.20; fi depmod: *** Unresolved symbols in 
> /lib/modules/2.4.20/kernel/drivers/mtd/maps/sc520cdp.o
> depmod:         mtd_concat_create_R606fc87b
> depmod:         mtd_concat_destroy_R9c645004
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.20/kernel/drivers/net/wan/comx.o
> depmod:         proc_get_inode
> 

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
