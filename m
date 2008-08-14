From: Greg KH <greg@kroah.com>
Subject: Re: linux-next: Tree for August 14 (sysfs/acpi errors)
Date: Thu, 14 Aug 2008 08:44:56 -0700
Message-ID: <20080814154456.GA26388@kroah.com>
References: <20080814172945.250a27f2.sfr@canb.auug.org.au> <20080814083828.d10e126d.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080814083828.d10e126d.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ak@linux.intel.com, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 14, 2008 at 08:38:28AM -0700, Randy Dunlap wrote:
> calling  param_sysfs_init+0x0/0x1e7
> ------------[ cut here ]------------
> WARNING: at fs/sysfs/dir.c:463 sysfs_add_one+0x35/0x3d()
> sysfs: duplicate filename 'acpi' can not be created

Why would this be a sysfs error, it's acpi doing something foolish,
that's why the sysfs layer is warning about it :)

thanks,

greg k-h
