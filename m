From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Resume from Memory very slow on 2.6.37+
Date: Mon, 17 Jan 2011 23:49:06 +0100
Message-ID: <201101172349.06993.rjw@sisk.pl>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46075 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082Ab1AQWty (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Jan 2011 17:49:54 -0500
In-Reply-To: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Monday, January 17, 2011, Jeff Chua wrote:
> I've just tried the recent linux git pull
> (e78bf5e6cbe837daa6ab628a5f679548742994d3) and suspend-to-memory
> works, but resume takes a very long time (30 seconds doing nothing).
> 
> Bisected and it says first bad commit is
> ca9b600be38c73b7d25acfb8b7e4e9a9e941d881

Hmm.  That's probably because acpi_os_unmap_memory() does the
synchronize_rcu(), but I have no idea why it might cause a problem to
occur in suspend_nvs_free().

What happens if you replace the acpi_os_map_memory() in
suspend_nvs_save() with ioremap_cache() and the acpi_os_unmap_memory() in
suspend_nvs_free() with iounmap() ?

Rafael


> commit ca9b600be38c73b7d25acfb8b7e4e9a9e941d881
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Fri Jan 7 01:45:58 2011 +0100
> 
>     ACPI / PM: Make suspend_nvs_save() use acpi_os_map_memory()
> 
>     It turns out that the NVS memory region that suspend_nvs_save()
>     attempts to map has been already mapped by acpi_os_map_memory(), so
>     suspend_nvs_save() should better use acpi_os_map_memory() for mapping
>     memory to avoid conflicts.
> 
>     Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> 
> I reverted the following commits, and system resumes without waiting ...
> 
> commit ca9b600be38c73b7d25acfb8b7e4e9a9e941d881
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Fri Jan 7 01:45:58 2011 +0100
> 
>     ACPI / PM: Make suspend_nvs_save() use acpi_os_map_memory()
> 
> commit 6d5bbf00d251cc73223a71422d69e069dc2e0b8d
> Author: Len Brown <len.brown@intel.com>
> Date:   Fri Jan 7 01:46:40 2011 +0100
> 
>     ACPI: Use ioremap_cache()
> 
> commit d146df18c13d16e321efa8ef9b57c95c3bec1722
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Fri Jan 7 01:44:28 2011 +0100
> 
>     ACPI / PM: Update file information and the list of includes in nvs.c
> 
> 
> Notebook is Lenovo X201s. 8GB RAM. 256GB SSD.
> 
> 
> Thanks,
> Jeff
> 
> 

