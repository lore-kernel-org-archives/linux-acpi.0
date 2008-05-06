From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] bay: Exit if notify handler cannot be installed
Date: Tue, 6 May 2008 11:15:22 +0200
Message-ID: <20080506091522.GA4378@homac>
References: <20080505202508.GA3690@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:34197 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755238AbYEFJNN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 May 2008 05:13:13 -0400
Content-Disposition: inline
In-Reply-To: <20080505202508.GA3690@homac>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com

On Mo 05. Mai - 22:25:08, Holger Macht wrote:
> If acpi_install_notify_handler() for a bay device fails, the bay driver is
> superfluous. Most likely, another driver (like libata) is already caring
> about this device anyway. Furthermore,
> register_hotplug_dock_device(acpi_handle) from the dock driver must not be
> called twice with the same handler. So clean up and exit.

The patch needs some more work. I'll send an updated one as soon as ready.

Regards,
	Holger
