From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Resume a K8T800 Mainboard from S3
Date: Sun, 18 Jun 2006 18:47:00 +0100
Message-ID: <20060618174700.GA14888@srcf.ucam.org>
References: <20060615144521.42691.qmail@web26503.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:32730 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932268AbWFRRrE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jun 2006 13:47:04 -0400
Content-Disposition: inline
In-Reply-To: <20060615144521.42691.qmail@web26503.mail.ukl.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: karsten wiese <annabellesgarden@yahoo.de>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

(patch that clears the abnormal power-off status on a VIA chipset)

This works for fixing suspend on the ECS G320 (which has a different 
southbridge) as well. A quick scan of what datasheets I can get my hands 
on suggest that the same register is used for the purpose on all VIA 
southbridges, so a more generic quirk might be helpful.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
