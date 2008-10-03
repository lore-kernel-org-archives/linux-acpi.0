From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2] thermal: Make it simpler to use the thermal layer inside the kernel
Date: Fri, 3 Oct 2008 18:10:17 +0100
Message-ID: <20081003171017.GA12820@srcf.ucam.org>
References: <20081001120420.GA29479@srcf.ucam.org> <20081001184111.GA3330@srcf.ucam.org> <200810031908.37618.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42134 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbYJCRKZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Oct 2008 13:10:25 -0400
Content-Disposition: inline
In-Reply-To: <200810031908.37618.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com, pavel@suse.cz

On Fri, Oct 03, 2008 at 07:08:36PM +0200, Thomas Renninger wrote:

> grep get_max_state drivers/misc/intel_menlow.c
>         .get_max_state = memory_get_max_bandwidth,

Oops, yeah. I'll fix that one up as well.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
