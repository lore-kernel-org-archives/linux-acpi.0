From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [origin tree boot crash] NULL pointer dereference, IP:
 [<ffffffff82b07130>] ibm_find_acpi_device+0x5c/0xf5
Date: Thu, 24 Sep 2009 09:58:30 +0800
Message-ID: <1253757510.9794.55.camel@minggr.sh.intel.com>
References: <alpine.LFD.2.00.0909190237560.22030@localhost.localdomain>
	 <20090923213052.GA6648@elte.hu>
	 <1253756114.9794.43.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39228 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117AbZIXCHH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Sep 2009 22:07:07 -0400
In-Reply-To: <1253756114.9794.43.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, bjorn.helgaas@hp.com
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-09-24 at 09:35 +0800, Lin Ming wrote:
> On Thu, 2009-09-24 at 05:30 +0800, Ingo Molnar wrote:
> > > commit 15b8dd53f5ffaf8e2d9095c423f713423f576c0f
> > > Date:   Mon Jun 29 13:39:29 2009 +0800
> > >
> > >     ACPICA: Major update for acpi_get_object_info external interface
> > 
> > this one is causing boot crashes in -tip testing:
> 
> Hi,
> 
> Could you please try below commit at linux-acpi-2.6/release branch.

Oh, sorry, commit 718fb0d was already in -tip testing.

(add Bjorn Helgaas <bjorn.helgaas@hp.com>)

Below patch should fix the crash.
http://patchwork.kernel.org/patch/49090/ 

Subject: [PATCH v3 01/17] ACPICA: fixup after acpi_get_object_info() change

Commit 15b8dd53f5ffa changed info->hardware_id from a static array to
a pointer.  If hardware_id is non-NULL, it points to a NULL-terminated
string, so we don't need to terminate it explicitly.  However, it may
be NULL; in that case, we *can't* add a NULL terminator.

This causes a NULL pointer dereference oops for devices without _HID.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Lin Ming <ming.m.lin@intel.com>
CC: Bob Moore <robert.moore@intel.com>
CC: Gary Hade <garyhade@us.ibm.com>
---
 drivers/pci/hotplug/acpiphp_ibm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index a9d926b..e7be66d 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -406,7 +406,6 @@ static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
 			__func__, status);
 		return retval;
 	}
-	info->hardware_id.string[sizeof(info->hardware_id.length) - 1] = '\0';
 
 	if (info->current_status && (info->valid & ACPI_VALID_HID) &&
 			(!strcmp(info->hardware_id.string, IBM_HARDWARE_ID1) ||


---
Lin Ming

> 
> commit 718fb0de8ff88f71b3b91a8ee8e42e60c88e5128
> Author: Hugh Dickins <hugh.dickins@tiscali.co.uk>
> Date:   Thu Aug 6 23:18:12 2009 +0000
> 
>     ACPI: fix NULL bug for HID/UID string
>     
>     acpi_device->pnp.hardware_id and unique_id are now allocated pointers,
>     replacing the previous arrays.  acpi_device_install_notify_handler()
>     oopsed on the NULL hid when probing the video device, and perhaps other
>     uses are vulnerable too.  So initialize those pointers to empty strings
>     when there is no hid or uid.  Also, free hardware_id and unique_id when
>     when acpi_device is going to be freed.
>     
>     http://bugzilla.kernel.org/show_bug.cgi?id=14096
>     
>     Signed-off-by: Hugh Dickins <hugh.dickins@tiscali.co.uk>
>     Signed-off-by: Lin Ming <ming.m.lin@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> Thanks,
> Lin Ming


