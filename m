From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Avoid critical temp shutdowns on specific ThinkPad T4x(p) and R50p
Date: Tue, 12 Aug 2008 09:02:50 +0100
Message-ID: <20080812080249.GA11913@srcf.ucam.org>
References: <200807301556.01815.trenn@suse.de> <200808111433.25275.trenn@suse.de> <20080811125519.GA26308@srcf.ucam.org> <200808111614.17161.trenn@suse.de> <20080811141552.GA28294@srcf.ucam.org> <48A1431A.8090300@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33801 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbYHLIC6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Aug 2008 04:02:58 -0400
Content-Disposition: inline
In-Reply-To: <48A1431A.8090300@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Renninger <trenn@suse.de>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Tue, Aug 12, 2008 at 10:00:26AM +0200, Andi Kleen wrote:

> The problem seems to be that some people report this as a regression.
> So either:

Yeah. I'm unconvinced that this is the right solution for the Thinkpad 
case.

> - It's an regression. Then something must have been changed. Do we know 
> what that is?
> If it's really an regression then we need a low-risk fix for .27.

The two choices would either seem to be that the system is now running 
hotter, or that we're getting spurious temperature readings.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
