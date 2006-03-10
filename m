From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [Pcihpd-discuss] question on what is ejectable?
Date: Fri, 10 Mar 2006 11:28:58 +0900
Message-ID: <4410E46A.8050409@jp.fujitsu.com>
References: <1141851331.32163.26.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:35032 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752117AbWCJCai (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Mar 2006 21:30:38 -0500
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
        by fgwmail7.fujitsu.co.jp (Fujitsu Gateway)
        with ESMTP id k2A2UZh1022913 for <linux-acpi@vger.kernel.org>; Fri, 10 Mar 2006 11:30:36 +0900
        (envelope-from kaneshige.kenji@jp.fujitsu.com)
Received: from s6.gw.fujitsu.co.jp by m5.gw.fujitsu.co.jp (8.12.10/Fujitsu Domain Master)
	id k2A2UY5o029090 for <linux-acpi@vger.kernel.org>; Fri, 10 Mar 2006 11:30:34 +0900
	(envelope-from kaneshige.kenji@jp.fujitsu.com)
Received: from s6.gw.fujitsu.co.jp (s6 [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 1F70A29C132
	for <linux-acpi@vger.kernel.org>; Fri, 10 Mar 2006 11:30:34 +0900 (JST)
Received: from ml6.s.css.fujitsu.com (ml6.s.css.fujitsu.com [10.23.4.196])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 09D1629C34D
	for <linux-acpi@vger.kernel.org>; Fri, 10 Mar 2006 11:30:33 +0900 (JST)
In-Reply-To: <1141851331.32163.26.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net

Kristen Accardi wrote:
> I notice in the acpi_bus_get_flags() function ejectable is defined as
> anything that has either _EJ0 or _EJD.  However, the acpi pci hotplug
> driver defines an ejectable slot as being one which must have (among
> other things) _EJ0.  Is it legitimate to change the definition of an
> ejectable slot to be one that has either _EJ0 or _EJD (in addition to
> the other requirements for pci hotplug slots).
> 

As the acpi_bus_get_flags() does, I think "ejectable device" is defined
as anything that has either _EJ0 or _EJD. But I don't think the device
is "ejectable slot" if it has _EJD but it doesn't have _EJ0. If an eject
request was notified to such devices, I don't know how to eject those.
I think one of the requirements for pci hotplug slots is having _EJ0.

Thanks,
Kenji Kaneshige
