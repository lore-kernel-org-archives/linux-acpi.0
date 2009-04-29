From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/5] ACPI: WMI: Add sysfs userspace interface
Date: Wed, 29 Apr 2009 21:38:08 +0100
Message-ID: <20090429203808.GC2944@srcf.ucam.org>
References: <20080205021658.4422.83165.stgit@pacifica> <20080205021721.4422.58508.stgit@pacifica> <20080827135327.GA7162@srcf.ucam.org> <200808272121.54882.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41750 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbZD2UiL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Apr 2009 16:38:11 -0400
Content-Disposition: inline
In-Reply-To: <200808272121.54882.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Now that we've got the new device_name() stuff, is it possible to add 
support for generating the modalias uevents in wmi? It'd be good to get 
the autoloading sorted properly.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
