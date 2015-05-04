From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Patch breaks suspend
Date: Tue, 05 May 2015 01:37:33 +0200
Message-ID: <2970725.6ieOiJg9HH@vostro.rjw.lan>
References: <55453334.9030002@yuhu.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57270 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751606AbbEDXMc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2015 19:12:32 -0400
In-Reply-To: <55453334.9030002@yuhu.biz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marian Marinov <mm-l@yuhu.biz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>

On Saturday, May 02, 2015 11:27:32 PM Marian Marinov wrote:
> Hi guys,
> I have Lenovo T520 with one SSD and one SATA drive.
> 
> I tried to upgrade to Linux 4.0 and found that after suspend and resume I can't access the second (SATA) drive.
> Both drives have bios encryption enabled.
> 
> I did a bisect and found that the following patch causes the issue:
> commit 5d5132059a1f652de9dc2d62a8ff15561e648d11
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Sat Feb 22 00:48:31 2014 +0100
> 
>     ACPI / ATA: Add hotplug contexts to ACPI companions of SATA devices
>    
>     Modify the SATA subsystem to add hotplug contexts to ACPI companions
>     of SATA devices and ports instead of registering special ACPI dock
>     operations using register_hotplug_dock_device().
>    
>     That change will allow the entire code handling those special ACPI
>     dock operations to be dropped in the next commit.
>    
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Reviewed-by: Aaron Lu <aaron.lu@intel.com>
>     Acked-by: Tejun Heo <tj@kernel.org>
> 
> Unfortunately I do not understand this part of the code and have no idea what I can do.
> Any pointers would be very appreciated.

Well, not right from the top of my head, but this looks really suspicious to me.

Can you please file a bug entry for this at bugzilla.kernel.org (in the ACPI/BIOS
category), assign it to me and CC Aaron?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
