From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] mm/hotplug: Remove stop_machine() from
 try_offline_node()
Date: Tue, 13 Aug 2013 08:44:48 -0600
Message-ID: <1376405088.10300.384.camel@misato.fc.hp.com>
References: <1376336071-9128-1-git-send-email-toshi.kani@hp.com>
	 <3940091.8hz2Z6IIgz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <3940091.8hz2Z6IIgz@vostro.rjw.lan>
Sender: owner-linux-mm@kvack.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kosaki.motohiro@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, tangchen@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, liwanp@linux.vnet.ibm.com
List-Id: linux-acpi@vger.kernel.org

On Tue, 2013-08-13 at 13:41 +0200, Rafael J. Wysocki wrote:
> On Monday, August 12, 2013 01:34:31 PM Toshi Kani wrote:
> > lock_device_hotplug() serializes hotplug & online/offline operations.
> > The lock is held in common sysfs online/offline interfaces and ACPI
> > hotplug code paths.
> > 
> > try_offline_node() off-lines a node if all memory sections and cpus
> > are removed on the node.  It is called from acpi_processor_remove()
> > and acpi_memory_remove_memory()->remove_memory() paths, both of which
> > are in the ACPI hotplug code.
> > 
> > try_offline_node() calls stop_machine() to stop all cpus while checking
> > all cpu status with the assumption that the caller is not protected from
> > CPU hotplug or CPU online/offline operations.  However, the caller is
> > always serialized with lock_device_hotplug().  Also, the code needs to
> > be properly serialized with a lock, not by stopping all cpus at a random
> > place with stop_machine().
> > 
> > This patch removes the use of stop_machine() in try_offline_node() and
> > adds comments to try_offline_node() and remove_memory() that
> > lock_device_hotplug() is required.
> > 
> > Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!
-Toshi


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
