From: "Kay Sievers" <kay.sievers@vrfy.org>
Subject: Re: linux-next: Tree for August 14 (sysfs/acpi errors)
Date: Fri, 15 Aug 2008 13:27:00 +0200
Message-ID: <3ae72650808150427q364842ccicf0a0978b30ca98c@mail.gmail.com>
References: <20080814172945.250a27f2.sfr@canb.auug.org.au>
	 <20080814083828.d10e126d.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080814083828.d10e126d.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, gregkh <greg@kroah.com>, ak@linux.intel.com, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 14, 2008 at 17:38, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> calling  param_sysfs_init+0x0/0x1e7
> ------------[ cut here ]------------
> WARNING: at fs/sysfs/dir.c:463 sysfs_add_one+0x35/0x3d()
> sysfs: duplicate filename 'acpi' can not be created

Hi Randy,
care to add a printk to the module sysfs setup, and post dmesg again?

--- a/kernel/params.c
+++ b/kernel/params.c
@@ -603,6 +603,8 @@ static void __init param_sysfs_builtin(void)
 		}
 		name_len = dot - kp->name;

+		printk("XXX adding modparam:'%s' %i (%p)\n", kp->name, i, kp);
+
  		/* new kbuild_modname? */
 		if (strlen(modname) != name_len
 		    || strncmp(modname, kp->name, name_len) != 0) {

I might show the order of registering the /sys/modules/ directory, and
if there is possibly another "acpi" section, which tries to add
parameter names.

Thanks,
Kay
