From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 4/5] ACPI: WMI: Add sysfs userspace interface
Date: Wed, 27 Aug 2008 21:21:54 +0100
Message-ID: <200808272121.54882.carlos@strangeworlds.co.uk>
References: <20080205021658.4422.83165.stgit@pacifica> <20080205021721.4422.58508.stgit@pacifica> <20080827135327.GA7162@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:57121 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbYH0UWF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 16:22:05 -0400
In-Reply-To: <20080827135327.GA7162@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wednesday 27 August 2008 14:53:27 Matthew Garrett wrote:
> Now that we're getting a proliferation of WMI drivers (I'm working on a
> Dell one at the moment), it'd be nice to be able to get the module
> autoloading support in. BUS_ID still seems to be limited to 20 bytes,
> though. Any thoughts on the best way to go from here?

Can we abuse uevent and cram all the GUID's into just one MODALIAS line?

Alternatively, maybe just have the directories numbered 1 to X, and have a 
uevent file under each, since we don't care about trying to abuse sysfs to 
let userspace talk to WMI anymore.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
