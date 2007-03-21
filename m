From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/8] [-mm] ACPI: add ACPI device sysfs interface
Date: Wed, 21 Mar 2007 15:17:01 +0800
Message-ID: <1174461421.8833.103.camel@localhost.localdomain>
References: <1174382471.8833.79.camel@localhost.localdomain>
	 <20070320153105.GD13042@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8813 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932825AbXCUHRk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Mar 2007 03:17:40 -0400
In-Reply-To: <20070320153105.GD13042@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Tue, 2007-03-20 at 12:31 -0300, Henrique de Moraes Holschuh wrote:
> On Tue, 20 Mar 2007, Zhang Rui wrote:
> > Add sysfs interface for ACPI devices.
> 
> While doing the ibm-acpi sysfs work (not submitted yet), I have found I need
> something like this to properly parse simple ulongs from sysfs:
> 
> static int parse_strtoul(const char *buf,
> 		unsigned long max, unsigned long *value)
> {
> 	char *endp;
> 
> 	*value = simple_strtoul(buf, &endp, 0);
> 	while (*endp && isspace(*endp))
> 		endp++;
> 	if (*endp || *value > max)
> 		return -EINVAL;
> 
> 	return 0;
> }
> 
Sounds nice.
But I think it can work better without the parameter "max".
Not all of the .store functions have "max" limit, e.g. the thermal
polling_freq, while some of them may need "max" and "min" limit both,
like fan state (0/3).
So why not just get the value and let the .store function judge it? :)

Thanks,
Rui.
