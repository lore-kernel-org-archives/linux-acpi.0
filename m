From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCHv2 2/2] ACPI/platform: Add ACPI ID for Intel MBI device
Date: Wed, 4 Dec 2013 01:30:01 +0000
Message-ID: <20131204013001.GA25037@srcf.ucam.org>
References: <1385100357-5459-1-git-send-email-david.e.box@linux.intel.com>
 <1386115178-7559-1-git-send-email-david.e.box@linux.intel.com>
 <1386115178-7559-3-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40969 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab3LDBaG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Dec 2013 20:30:06 -0500
Content-Disposition: inline
In-Reply-To: <1386115178-7559-3-git-send-email-david.e.box@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Dec 03, 2013 at 03:59:38PM -0800, David E. Box wrote:
> From: "David E. Box" <david.e.box@linux.intel.com>
> 
> Adds ACPI ID for Intel IOSF-SB MailBox device found in BayTrail platforms.

Little bit confused here. This is a new driver and only declares 
modaliases for the ACPI IDs - why does it need to be added here?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
