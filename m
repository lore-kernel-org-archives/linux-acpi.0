From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] lpc_ich: Fix a 3.5 kernel regression for iTCO_wdt
 driver
Date: Wed, 22 Aug 2012 22:55:43 +0100
Message-ID: <20120822215543.GA1954@srcf.ucam.org>
References: <1344959772-23018-1-git-send-email-feng.tang@intel.com>
 <20120822195512.GI27604@spo001.leaseweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54495 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab2HVVzz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Aug 2012 17:55:55 -0400
Content-Disposition: inline
In-Reply-To: <20120822195512.GI27604@spo001.leaseweb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Len Brown <len.brown@intel.com>, Feng Tang <feng.tang@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Aaron Sierra <asierra@xes-inc.com>, Bob Moore <robert.moore@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>

On Wed, Aug 22, 2012 at 09:55:12PM +0200, Wim Van Sebroeck wrote:

> Any idea why the acpi_check_resource_conflict() check gives a conflict?

Because the resource range is declared in ACPI and we assume that that 
means the firmware wants to scribble on it. We'd need the output of 
acpidump to work out whether that's safe or not.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
