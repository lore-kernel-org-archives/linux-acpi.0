From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Resume from Memory very slow on 2.6.37+
Date: Wed, 19 Jan 2011 02:38:18 +0100
Message-ID: <201101190238.18529.rjw@sisk.pl>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com> <201101182120.16835.rjw@sisk.pl> <AANLkTikay6g5rOyDnv_ocz49GvUcQN+OkrusrbcRPB0K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52838 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297Ab1ASBjX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Jan 2011 20:39:23 -0500
In-Reply-To: <AANLkTikay6g5rOyDnv_ocz49GvUcQN+OkrusrbcRPB0K@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wednesday, January 19, 2011, Jeff Chua wrote:
> On Wed, Jan 19, 2011 at 4:20 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Please apply the appended patch (without the previous one) and post a dmesg
> > log containing a suspend-resume cycle with the delay.  I wonder where exactly
> > the delay occurs.
> > +       pr_info("%s: synchronize_rcu()\n", __func__);
> >        synchronize_rcu();
> > +       pr_info("%s: iounmap(%p), physaddr: %llx, size: %u\n", __func__,
> > +               map->virt, map->phys, map->size);
> 
> Rafael,
> 
> The 30 seconds is due to this ...
> 
> PM: Syncing filesystems ... done.
> Freezing user space processes ... _memory: synchronize_rcu()
> acpi_os_unmap_memory: iounmap(ffffc90001c22000), physaddr: bb398000, size: 4096
> acpi_os_unmap_memory: synchronize_rcu()
> acpi_os_unmap_memory: iounmap(ffffc90001c26000), physaddr: bb399000, size: 4096
> acpi_os_unmap_memory: synchronize_rcu()
> acpi_os_unmap_memory: iounmap(ffffc90001c2a000), physaddr: bb39a000, size: 4096
> acpi_os_unmap_memory: synchronize_rcu()
> acpi_os_unmap_memory: iounmap(ffffc90001c2e000), physaddr: bb39b000, size: 4096
> <repeat till ...>
> acpi_os_unmap_memory: iounmap(ffffc90003538000), physaddr: bb79d000, size: 4096
> acpi_os_unmap_memory: synchronize_rcu()
> acpi_os_unmap_memory: iounmap(ffffc9000353c000), physaddr: bb79e000, size: 4096
> Restarting tasks ... done.
> 
> After this, I see my X windows.

Are you able to say whether the synchronize_rcu() or the iounmap() calls block?

Rafael
