From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/5] ACPI: WMI: Add sysfs userspace interface
Date: Wed, 27 Aug 2008 21:44:49 +0100
Message-ID: <20080827204449.GA14925@srcf.ucam.org>
References: <20080205021658.4422.83165.stgit@pacifica> <20080205021721.4422.58508.stgit@pacifica> <20080827135327.GA7162@srcf.ucam.org> <200808272121.54882.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54976 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbYH0Uox (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 16:44:53 -0400
Content-Disposition: inline
In-Reply-To: <200808272121.54882.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wed, Aug 27, 2008 at 09:21:54PM +0100, Carlos Corbacho wrote:

> Can we abuse uevent and cram all the GUID's into just one MODALIAS line?

Looking at the udev rules, I suspect we need one event per GUID.

> Alternatively, maybe just have the directories numbered 1 to X, and have a 
> uevent file under each, since we don't care about trying to abuse sysfs to 
> let userspace talk to WMI anymore.

Yeah, that'd work for me.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
