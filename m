From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [Pcihpd-discuss] [patch] acpiphp: handle dock stations
Date: Tue, 14 Feb 2006 00:57:38 +0900
Message-ID: <43F0AC72.8010603@jp.fujitsu.com>
References: <20060201233005.GA4999@nerpa> <8764nkf2mq.wl%muneda.takahiro@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:42704 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750808AbWBMQAy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Feb 2006 11:00:54 -0500
In-Reply-To: <8764nkf2mq.wl%muneda.takahiro@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, Kristen Carlson Accardi <kristenc@cs.pdx.edu>
Cc: pcihpd-discuss@lists.sourceforge.net, greg@kroah.com, len.brown@intel.com, pavel@ucw.cz, linux-acpi@vger.kernel.org

Hi Kristen, Takahiro,

MUNEDA Takahiro wrote:
> 
> I tried 2.6.12-rc2-mm1(includes this patch) on my Tiger box,
> I could not insmod the acpiphp module because of the NaT
> consumption.
> 
> My box does not have any _DCK method, so find_dock() returns
> without making any acpiphp_dock_station struct. Therefore,
> NaT consumption has occurred at get_dependent_device().
> 

This problem will be fixed by the following patch.

Thanks,
Kenji Kaneshige


The get_dependent_device() function must check if ds is not NULL,
otherwise it will cause kernel panic on the system that has no _DCK
method.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 drivers/pci/hotplug/acpiphp_dock.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.16-rc2-mm1/drivers/pci/hotplug/acpiphp_dock.c
===================================================================
--- linux-2.6.16-rc2-mm1.orig/drivers/pci/hotplug/acpiphp_dock.c	2006-02-09 20:03:03.000000000 +0900
+++ linux-2.6.16-rc2-mm1/drivers/pci/hotplug/acpiphp_dock.c	2006-02-14 00:11:15.000000000 +0900
@@ -88,6 +88,9 @@
 {
 	struct dependent_device *dd;
 
+	if (!ds)
+		return NULL;
+
 	list_for_each_entry(dd, &ds->dependent_devices, device_list) {
 		if (handle == dd->handle)
 			return dd;

