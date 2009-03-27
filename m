From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ACPI: Adjust Kelvin offset to match local
 implementation
Date: Fri, 27 Mar 2009 10:55:20 +0100
Message-ID: <20090327105520.6fa31a13@hyperion.delvare>
References: <20090301140318.5cf56287@hyperion.delvare>
	<1236069854.32297.232.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:29197 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830AbZC0Jzd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 05:55:33 -0400
In-Reply-To: <1236069854.32297.232.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

Hi Rui,

On Tue, 03 Mar 2009 16:44:14 +0800, Zhang Rui wrote:
> On Sun, 2009-03-01 at 21:03 +0800, Jean Delvare wrote:
> > The exact offset between Kelvin and degree Celsius is 273.15. However
> > ACPI handles temperature values with a single decimal place. As a
> > consequence, some implementations use an offset of 273.1 and others
> > use an offset of 273.2. Try to find out which one is being used, to
> > present the most accurate and visually appealing number.
> > 
> > Tested on a Sony Vaio PGC-GR214EP (which uses 273.1) and a Lenovo
> > Thinkpad T60p (which uses 273.2).
> Sounds reasonable.
> 
> Acked-by: Zhang Rui <rui.zhang@intel.com>

Thanks. Is this patch queued for 2.6.30 somewhere?

-- 
Jean Delvare
