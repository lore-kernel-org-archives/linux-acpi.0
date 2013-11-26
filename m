From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi: Add BayTrail SoC GPIO and LPSS ACPI IDs
Date: Tue, 26 Nov 2013 01:03:48 +0000
Message-ID: <20131126010348.GA29198@srcf.ucam.org>
References: <1385417755-21776-1-git-send-email-paul.drews@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35044 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab3KZBEE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Nov 2013 20:04:04 -0500
Content-Disposition: inline
In-Reply-To: <1385417755-21776-1-git-send-email-paul.drews@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Drews <paul.drews@intel.com>
Cc: lenb@kernel.org, rjw@rjwysocki.net, linus.walleij@linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Nov 25, 2013 at 02:15:55PM -0800, Paul Drews wrote:
> This adds the new ACPI ID (INT33FC) for the BayTrail GPIO
> banks as seen on a BayTrail M System-On-Chip platform.  This
> ACPI ID is used by the BayTrail GPIO (pinctrl) driver to
> manage the Low Power Subsystem (LPSS).

Not that we can do anything about this now, but if they have the same 
programming model why isn't there a CID that covers them?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
