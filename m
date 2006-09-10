From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: io-apic breaks suspend unless acpi_skip_timer_override
Date: Sun, 10 Sep 2006 15:15:34 +0100
Message-ID: <20060910141533.GA6594@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:59015 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932172AbWIJOPg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Sep 2006 10:15:36 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

ACPI suspend/resume fails on my HP nx6125 unless I either:

a) boot with noapic, or
b) boot with acpi_skip_timer_override

Does anyone have the faintest idea how to debug this?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
