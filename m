From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi: Update battery information on notification 0x81
Date: Mon, 3 Jan 2011 17:59:15 +0000
Message-ID: <20110103175915.GA789@srcf.ucam.org>
References: <1281990739-17912-1-git-send-email-mjg@redhat.com> <20101215171928.GA17746@srcf.ucam.org> <20101223211638.GA7862@srcf.ucam.org> <201012232323.42702.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51990 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab1ACR7W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jan 2011 12:59:22 -0500
Content-Disposition: inline
In-Reply-To: <201012232323.42702.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org

On Thu, Dec 23, 2010 at 11:23:42PM +0100, Rafael J. Wysocki wrote:

> As I've already said on IRC, I'd simply add a new function like:
> 
> void acpi_battery_refresh(struct acpi_battery *battery)
> {
> 	if (!battery->bat.dev)
> 		return;
> 	acpi_battery_get_info(battery);
> 	/* The battery may have changed its reporting units */
> 	sysfs_remove_battery(battery);
> 	sysfs_add_battery(battery);
> }
> 
> and call it before acpi_battery_update()
> (a) in acpi_battery_resume()
> (b) in acpi_battery_notify() if event == ACPI_BATTERY_NOTIFY_INFO
> 
> That would be more straightforward IMHO.

That might be more reasonable. Want to send that, or shall I?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
