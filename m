From: Olaf Dietsche <olaf.dietsche#list.linux-kernel-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: Re: 2.5.44: How to decode call trace
Date: Wed, 23 Oct 2002 12:33:25 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <878z0p1m2y.fsf@goat.bogus.local>
References: <87elai82xb.fsf@goat.bogus.local.suse.lists.linux.kernel>
	<p73isztstim.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org> writes:

> Olaf Dietsche <olaf.dietsche#list.linux-kernel-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org> writes:
>> and this is the code:
>> static int __fscap_lookup(struct vfsmount *mnt, struct nameidata *nd)
>> {
>> 	static char name[] = ".capabilities";
>> 	nd->mnt = mntget(mnt);
>> 	nd->dentry = dget(mnt->mnt_sb->s_root);
>> 	nd->flags = 0;
>> 	return path_walk(name, nd);
>> }
>> 
>> What does .text.lock.namei and name.810 mean?
>
> .text.lock.namei means that it hung in the slow path of a spinlock that
> is referenced from namei.c

I guess this is what __down_failed means.

> name.810 is a static data variable, probably the static char name[]
> shown above. Remember the kernel backtrace is not exact and can print
> random stack junk that looks like return addresses too. You always have 
> to sanity check each entry.

Ok, I'll keep that in mind.

>> Is there a way to get the line number out of these hex values?
>
> addr2line -e vmlinux ... does this when you compile the kernel with -g 

Great! This is what I was searching for.

When I build with "make -k EXTRA_CFLAGS=-g EXTRA_LDFLAGS=-g bzImage",
I get a ton of error messages from drivers/acpi/include/actypes.h and
other acpi related stuff, starting with: #error ACPI_MACHINE_WIDTH not
defined. Maybe this is not the usual way to build with -g, but I don't
get these errors with "make -k bzImage". Maybe someone is interested
in this.

Anyway, I come around this by first building with "EXTRA_CFLAGS=-g
EXTRA_LDFLAGS=-g", ignoring the error messages and then a second try
with only EXTRA_LDFLAGS=-g.

Regards, Olaf.
