From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/4] [RFC] ACPI: WMI: Add sysfs userspace interface
Date: Wed, 26 Dec 2007 19:38:22 +0000
Message-ID: <20071226193821.GA30729@srcf.ucam.org>
References: <20071218235137.12838.75397.stgit@localhost> <20071218235200.12838.13702.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:36338 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbXLZTig (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Dec 2007 14:38:36 -0500
Content-Disposition: inline
In-Reply-To: <20071218235200.12838.13702.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

+               memcpy(guid_dev->bus_id, guid_string, 36);

bus_id is only 20 bytes long at the moment...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
