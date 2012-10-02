From: "Ortiz, Lance E" <lance.oritz@hp.com>
Subject: RE: [acpi:next 4/5] drivers/acpi/scan.c:328
 acpi_device_remove_files() info: redundant null check on dev->pnp.str_obj
 calling kfree()
Date: Tue, 2 Oct 2012 18:53:05 +0000
Message-ID: <A961433CDFF2F640A2866803152E61F950D26B71@G4W3226.americas.hpqcorp.net>
References: <20121002073952.GA24180@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:24622 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab2JBSyP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Oct 2012 14:54:15 -0400
In-Reply-To: <20121002073952.GA24180@localhost>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Len Brown <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Thanks for letting me know. I send out an updated patch removing the redundant check.  But I am wondering if we should leave it in for safety's sake.  Is having a info message like this from smatch a problem?

Lance

-----Original Message-----
From: Fengguang Wu [mailto:fengguang.wu@intel.com] 
Sent: Tuesday, October 02, 2012 1:40 AM
To: Ortiz, Lance E
Cc: kernel-janitors@vger.kernel.org; Len Brown; linux-acpi@vger.kernel.org; linux-pm@vger.kernel.org
Subject: [acpi:next 4/5] drivers/acpi/scan.c:328 acpi_device_remove_files() info: redundant null check on dev->pnp.str_obj calling kfree()

Hi Lance,

FYI, there are new smatch warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git next
head:   10eaea0474b0078bb84ff9009329b83d3e30337f
commit: 2bc8195d56163f54d3036304efa8d71ab1091bf1 [4/5] ACPI: Add new sysfs interface to export device description

+ drivers/acpi/scan.c:328 acpi_device_remove_files() info: redundant null check on dev->pnp.str_obj calling kfree()

vim +328 drivers/acpi/scan.c

e49bd2dd (Zhang Rui      2006-12-08  312) 		result = device_create_file(&dev->dev, &dev_attr_eject);
0c526d96 (Alex Chiang    2009-05-14  313) end:
e49bd2dd (Zhang Rui      2006-12-08  314) 	return result;
^1da177e (Linus Torvalds 2005-04-16  315) }
^1da177e (Linus Torvalds 2005-04-16  316) 
f883d9db (Patrick Mochel 2006-12-07  317) static void acpi_device_remove_files(struct acpi_device *dev)
^1da177e (Linus Torvalds 2005-04-16  318) {
f883d9db (Patrick Mochel 2006-12-07  319) 	acpi_status status;
f883d9db (Patrick Mochel 2006-12-07  320) 	acpi_handle temp;
^1da177e (Linus Torvalds 2005-04-16  321) 
f883d9db (Patrick Mochel 2006-12-07  322) 	/*
2bc8195d (Lance Ortiz    2012-09-07  323) 	 * If device has _STR, remove 'description' file
2bc8195d (Lance Ortiz    2012-09-07  324) 	 */
2bc8195d (Lance Ortiz    2012-09-07  325) 	status = acpi_get_handle(dev->handle, "_STR", &temp);
2bc8195d (Lance Ortiz    2012-09-07  326) 	if (ACPI_SUCCESS(status)) {
2bc8195d (Lance Ortiz    2012-09-07  327) 		if (dev->pnp.str_obj != NULL)
2bc8195d (Lance Ortiz    2012-09-07 @328) 			kfree(dev->pnp.str_obj);
2bc8195d (Lance Ortiz    2012-09-07  329) 		device_remove_file(&dev->dev, &dev_attr_description);
2bc8195d (Lance Ortiz    2012-09-07  330) 	}
2bc8195d (Lance Ortiz    2012-09-07  331) 	/*
2bc8195d (Lance Ortiz    2012-09-07  332) 	 * If device has _EJ0, remove 'eject' file.
f883d9db (Patrick Mochel 2006-12-07  333) 	 */
f883d9db (Patrick Mochel 2006-12-07  334) 	status = acpi_get_handle(dev->handle, "_EJ0", &temp);
f883d9db (Patrick Mochel 2006-12-07  335) 	if (ACPI_SUCCESS(status))
f883d9db (Patrick Mochel 2006-12-07  336) 		device_remove_file(&dev->dev, &dev_attr_eject);

---
0-DAY kernel build testing backend         Open Source Technology Centre
Fengguang Wu, Yuanhan Liu                              Intel Corporation
