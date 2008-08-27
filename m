From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/5] ACPI: WMI: Add sysfs userspace interface
Date: Wed, 27 Aug 2008 14:53:27 +0100
Message-ID: <20080827135327.GA7162@srcf.ucam.org>
References: <20080205021658.4422.83165.stgit@pacifica> <20080205021721.4422.58508.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50641 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758334AbYH0Nxd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 09:53:33 -0400
Content-Disposition: inline
In-Reply-To: <20080205021721.4422.58508.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Hi Carlos,

Now that we're getting a proliferation of WMI drivers (I'm working on a 
Dell one at the moment), it'd be nice to be able to get the module 
autoloading support in. BUS_ID still seems to be limited to 20 bytes, 
though. Any thoughts on the best way to go from here?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
