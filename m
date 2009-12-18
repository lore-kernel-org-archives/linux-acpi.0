From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/5 -v2] acpi, apei, HEST table parsing
Date: Fri, 18 Dec 2009 19:44:47 +0100
Message-ID: <20091218184443.GD1470@ucw.cz>
References: <1260429419.15264.395.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43451 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbZLRSpA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2009 13:45:00 -0500
Content-Disposition: inline
In-Reply-To: <1260429419.15264.395.camel@yhuang-dev.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Thu 2009-12-10 15:16:59, Huang Ying wrote:
> HEST describes error sources in detail; communicating operational
> parameters (i.e. severity levels, masking bits, and threshold values)
> to OS as necessary. It also allows the platform to report error
> sources for which OS would typically not implement support (for
> example, chipset-specific error registers).
> 
> HEST information may be needed by other subsystems. For example, HEST
> PCIE AER error source information describes whether a PCIE root port
> works in "firmware first" mode, this is needed by general PCIE AER
> error subsystem. So a public HEST tabling parsing interface is
> provided.

Perhaps you can remove unused hest_exit()?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
