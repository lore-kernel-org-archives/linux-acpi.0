From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete acpi_os_validate_address interface"
Date: Wed, 1 Jul 2009 10:56:35 +0200
Message-ID: <200907011056.36545.trenn@suse.de>
References: <1246415391.24831.30.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40082 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbZGAI4e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2009 04:56:34 -0400
In-Reply-To: <1246415391.24831.30.camel@minggr.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi Lin,

thanks for adding me.
This is not "that" sever, but IMO this one should also be submitted
to 2.6.30 stable kernels as it is a riskless revert of a patch
fixing a regression.

On Wednesday 01 July 2009 04:29:51 Lin Ming wrote:
>     Revert "ACPICA: Remove obsolete acpi_os_validate_address interface"
>     
>     This reverts commit f9ca058430333c9a24c5ca926aa445125f88df18.
>     
>     The quick fix of bug 13620 would be to revert the change.
>     http://bugzilla.kernel.org/show_bug.cgi?id=13620
>     
>     Also, see the commit df92e695998e1bc6e426a840eb86d6d1ee87e2a5
>     "ACPI: track opregion names to avoid driver resource conflicts."
>     
>     But there are problems we need to address:
>     
>     1. We need to enhance the mechanism of avoiding driver resource
>     conflicts
>        to base a "resource" on Field definitions instead of Operation Region
>        definitions.
Good idea, this could avoid some false positive detected region conflicts.
>     
>     2. For dynamic region, we need an interface to call when an operation
>     region (field) is deleted,
>        in order to delete it from the resource list.
>     
>     3. If the same region is created and added to resource list over and
>     over again,
>        this is have the potential to be a memory leak by growing the list
>        every time
Region or field or both?
How can this happen, can you show a little ASL snippet or explain this a bit 
more detailed, please. I do not fully understand what is meant in 3.

Thanks,

  Thomas
