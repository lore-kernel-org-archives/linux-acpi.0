From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] ACPI: battery: add sysfs serial number
Date: Tue, 22 Jan 2008 21:15:07 +0300
Message-ID: <479632AB.2030709@suse.de>
References: <1201024010-6103-1-git-send-email-max@stro.at> <47962F29.7000102@suse.de> <20080122180724.GB5009@baikonur.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:41180 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751696AbYAVSPz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 13:15:55 -0500
In-Reply-To: <20080122180724.GB5009@baikonur.stro.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

maximilian attems wrote:
> On Tue, Jan 22, 2008 at 09:00:09PM +0300, Alexey Starikovskiy wrote:
>> ACK
> 
> thanks for your quick response!
> 
> while checking the missing bits of ACPI_SYSFS_POWER versus
> ACPI_PROCFS_POWER i also noticed capacity granularity.
> is that used by anyone?
IMHO, nobody cares about it.
> 
> if yes i can send another patch for that too.
SBS (sbs.c) has cycle_count field, which might be useful too, 
so you might want to show it as well.

> want to switch debian to ACPI_SYSFS_POWER.
Good luck!
