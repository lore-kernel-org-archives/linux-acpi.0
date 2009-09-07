From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH] acpi: make ACPI_DOCK a tristate option again (v2)
Date: Mon, 07 Sep 2009 09:18:21 +0100
Message-ID: <4AA4DDED0200007800013BA2@vpn.id2.novell.com>
References: <4AA4D99D0200007800013B7C@vpn.id2.novell.com>
 <20090907080413.GA29001@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vpn.id2.novell.com ([195.33.99.129]:25677 "EHLO
	vpn.id2.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbZIGISV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2009 04:18:21 -0400
In-Reply-To: <20090907080413.GA29001@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

>>> Shaohua Li <shaohua.li@intel.com> 07.09.09 10:04 >>>
>On Mon, Sep 07, 2009 at 03:59:57PM +0800, Jan Beulich wrote:
>> I cannot follow the explanation in commit
>> 898b054f3eec5921320ae8614b5bdd7b07ea5b43: If other drivers require the
>> dock module to be loaded before them, they sould simply have a
>> dependency on dock.ko. In the particular case mentioned (libata), this
>> already is the case.
>it has dependence with libata. Looks libata isn't module, right?

libata can be a module, and in that case dock likewise can be - the latter
will always be loaded before the former due to the dependency between
the two modules.

Jan

