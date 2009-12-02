From: Thomas Renninger <trenn@suse.de>
Subject: Re: regression: 2.6.32-rc8 shuts down after reaching critical temperature
Date: Wed, 2 Dec 2009 13:00:06 +0100
Message-ID: <200912021300.08020.trenn@suse.de>
References: <20091125102857.GA28310@lst.de> <alpine.LFD.2.00.0911251647000.3950@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58888 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbZLBMAC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Dec 2009 07:00:02 -0500
In-Reply-To: <alpine.LFD.2.00.0911251647000.3950@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Wednesday 25 November 2009 22:56:19 Len Brown wrote:
> On Wed, 25 Nov 2009, Christoph Hellwig wrote:

> If you can send along the dmesg from the recent failing kernel,
> plus the output from "grep . /proc/acpi/thermal_zone/*/*"
Do we have something similar easy for the /sys/ interface?
If yes, better propagate this one.
If not, it would be useful to have it before /proc/acpi dies?

    Thomas
