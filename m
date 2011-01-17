From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Resume from Memory very slow on 2.6.37+
Date: Mon, 17 Jan 2011 11:55:12 -0700
Message-ID: <E87738D94A6AD54789B5B8D1BAEB06CC700C91588E@azsmsx503.amr.corp.intel.com>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:24984 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538Ab1AQSzh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jan 2011 13:55:37 -0500
In-Reply-To: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

added Linux-acpi to cc

> -----Original Message-----
> From: Jeff Chua [mailto:jeff.chua.linux@gmail.com]
> Sent: Monday, January 17, 2011 8:36 AM
> To: Rafael J. Wysocki; Brown, Len; Jack Steiner; Linus Torvalds
> Subject: Resume from Memory very slow on 2.6.37+
> 
> I've just tried the recent linux git pull
> (e78bf5e6cbe837daa6ab628a5f679548742994d3) and suspend-to-memory
> works, but resume takes a very long time (30 seconds doing nothing).
> 
> Bisected and it says first bad commit is
> ca9b600be38c73b7d25acfb8b7e4e9a9e941d881
> 
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

any difference if you boot with acpi_sleep=nonvs ?

thanks,
-Len

