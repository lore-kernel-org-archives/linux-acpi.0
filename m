From: Matthias Hopf <mhopf@suse.de>
Subject: Re: [PATCH] ACPI / PM: Traverse video_device_list for backlight
	restoration
Date: Tue, 3 Aug 2010 12:11:57 +0200
Message-ID: <20100803101157.GA29721@suse.de>
References: <20100803100505.GA26948@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36813 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755758Ab0HCKL7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Aug 2010 06:11:59 -0400
Content-Disposition: inline
In-Reply-To: <20100803100505.GA26948@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Julia Lawall <julia@diku.dk>, Oliver
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org

A bit of background about this patch:


acpi_video_bus_get_devices() explicitly calls acpi_video_device_enumerate()
before acpi_video_bus_get_one_device(), which does acpi_video_device_bind().

In _enumerate(), active_list[] is created, with .bind_info explicitly set to
NULL, while the related .bind_info entry in video_device_list is set to the
acpi_video_device ptr in _bind().

The .bind_info is later used in acpi_video_resume() to re-set the backlight
- but it's only evaluated on the active_list[], on which all .bind_info are
NULL by construction.  This results in backlight not being restored, if the
BIOS doesn't do this by itself already.


The patch resolves this by replacing the active_list[] traversal by a
video_device_list traversal, but due to the nature of the issue I'm unsure
whether the original issue isn't of more principal quality.  I don't understand
why the list is (partially) transformed into an array in the first place,
especially as both the array *and* the list are used in the code...


Thanks

Matthias

-- 
Matthias Hopf <mhopf@suse.de>      __        __   __
Maxfeldstr. 5 / 90409 Nuernberg   (_   | |  (_   |__          mat@mshopf.de
Phone +49-911-74053-715           __)  |_|  __)  |__  R & D   www.mshopf.de
