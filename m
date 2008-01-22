From: maximilian attems <max@stro.at>
Subject: Re: [PATCH] ACPI: battery: add sysfs serial number
Date: Tue, 22 Jan 2008 19:07:24 +0100
Message-ID: <20080122180724.GB5009@baikonur.stro.at>
References: <1201024010-6103-1-git-send-email-max@stro.at> <47962F29.7000102@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:55810 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbYAVSIt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 13:08:49 -0500
Content-Disposition: inline
In-Reply-To: <47962F29.7000102@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Tue, Jan 22, 2008 at 09:00:09PM +0300, Alexey Starikovskiy wrote:
> ACK

thanks for your quick response!

while checking the missing bits of ACPI_SYSFS_POWER versus
ACPI_PROCFS_POWER i also noticed capacity granularity.
is that used by anyone?

if yes i can send another patch for that too.
want to switch debian to ACPI_SYSFS_POWER.

-- 
maks
