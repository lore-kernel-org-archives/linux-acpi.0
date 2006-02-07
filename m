From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Determining whether the system is on AC power or not
Date: Tue, 7 Feb 2006 15:52:44 +0000
Message-ID: <20060207155244.GA4919@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:11997 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965144AbWBGPwu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Feb 2006 10:52:50 -0500
Received: from mjg59 by vavatch.codon.org.uk with local (Exim 4.52)
	id 1F6V92-0001K4-IW
	for linux-acpi@vger.kernel.org; Tue, 07 Feb 2006 15:52:44 +0000
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

It would be helpful for drivers to be able to determine whether a system 
is currently on AC power or not (for instance, cases where backlight 
brightness is stored separately for AC and DC). There currently doesn't 
seem to be any way to export that information from the ACPI drivers. 
Would it be reasonable to add a mechanism for doing so?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
