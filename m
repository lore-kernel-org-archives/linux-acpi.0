From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 4/5] ACPI: WMI: Add sysfs userspace interface
Date: Wed, 29 Apr 2009 22:09:59 +0100
Message-ID: <200904292210.00617.carlos@strangeworlds.co.uk>
References: <20080205021658.4422.83165.stgit@pacifica> <200808272121.54882.carlos@strangeworlds.co.uk> <20090429203808.GC2944@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:37013 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769AbZD2VKX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Apr 2009 17:10:23 -0400
In-Reply-To: <20090429203808.GC2944@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wednesday 29 April 2009 21:38:08 Matthew Garrett wrote:
> Now that we've got the new device_name() stuff, is it possible to add
> support for generating the modalias uevents in wmi? It'd be good to get
> the autoloading sorted properly.

Mario asked me about this yesterday.

I have a patch I've started working on - it compiles and at least boots on my 
laptop, but not thorough tested or finished yet:

http://files.strangeworlds.co.uk/PATCH-4_5-RFC-ACPI-WMI-Add-sysfs-userspace-
interface.mbox

I can try and pick it up again if I have time, though I'm happy if anyone else 
wants to pick this up.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
