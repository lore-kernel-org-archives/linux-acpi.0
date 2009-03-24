From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Tue, 24 Mar 2009 00:05:43 -0700
Message-ID: <49C88647.8080404@goop.org>
References: <49C484B7.20100@goop.org> <200903231920.12991.rjw@sisk.pl> <49C7DDDC.2050103@goop.org> <200903232127.40683.rjw@sisk.pl> <49C86C41.1060803@goop.org> <0A882F4D99BBF6449D58E61AAFD7EDD60E5E877A@pdsmsx502.ccr.corp.intel.com> <49C872D1.8060403@goop.org> <0A882F4D99BBF6449D58E61AAFD7EDD60E5E877B@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:39232 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbZCXHFq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Mar 2009 03:05:46 -0400
In-Reply-To: <0A882F4D99BBF6449D58E61AAFD7EDD60E5E877B@pdsmsx502.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Cihula, Joseph" <joseph.cihula@intel.com>

Tian, Kevin wrote:
> OK, then it's safe to avoid that change. I had thought that dom0's 0-1M
> is identity-mapped to machine 0-1M... :-)

No, only the ISA 640k-1M region.

    J

