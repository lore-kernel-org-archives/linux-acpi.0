From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: enabled and failed flags in acpi_memory_info
Date: Mon, 14 Jan 2013 14:06:57 -0700
Message-ID: <1358197617.14145.92.camel@misato.fc.hp.com>
References: <1357693472.14145.42.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:33186 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756503Ab3ANVQp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jan 2013 16:16:45 -0500
In-Reply-To: <1357693472.14145.42.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: wency@cn.fujitsu.com
Cc: isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org

Wen, Yasuaki, any thoughts on this?

Thanks,
-Toshi


On Tue, 2013-01-08 at 18:04 -0700, Toshi Kani wrote:
> Hi Wen,
> 
> I have a question about the change you made in commit 65479472 in
> acpi_memhotplug.c.  This change seems to require that
> acpi_memory_enable_device() calls add_memory() to add all memory ranges
> represented by memory device objects at boot-time, and keep the results
> be used for hot-remove.  
> 
> If I understand it right, this add_memory() call fails with EEXIST at
> boot-time since all memory ranges should have been added from EFI memory
> table (or e820) already.  This results all memory ranges be marked as !
> enabled & !failed.  I think this means that we cannot hot-delete any
> memory ranges presented at boot-time since acpi_memory_remove_memory()
> only calls remove_memory() when the enabled flag is set.  Is that
> correct?  If so, why do we need such restriction?
> 
> In addition, as part of RFC patchset of proposed hotplug framework below
> (well, this is why I am wondering this... :), I simply called
> add_memory() and remove_memory() for the ranges requested for hot-add /
> hot-delete.  It does not call add_memory() at boot-time and set the
> enabled & failed flags.  But it does not eject memory when
> remove_memory() failed, either.  Do you see any problems with this
> approach? 
> https://lkml.org/lkml/2012/12/12/457
> 
> Thanks,
> -Toshi


