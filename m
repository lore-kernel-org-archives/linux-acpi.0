From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: kdump failed because of hotplug memory adding in kdump kernel
Date: Fri, 10 Jan 2014 08:19:27 -0700
Message-ID: <1389367167.1792.148.camel@misato.fc.hp.com>
References: <20140109145035.GB25897@redhat.com>
	 <1389283439.1792.66.camel@misato.fc.hp.com>
	 <20140109162427.GF25897@redhat.com>
	 <1389288265.1792.108.camel@misato.fc.hp.com>
	 <20140109182310.GG25897@redhat.com>
	 <1389292470.1792.109.camel@misato.fc.hp.com>
	 <20140109212705.GC12111@redhat.com>
	 <1389304583.1792.139.camel@misato.fc.hp.com>
	 <20140110071124.GA6464@dhcp-16-105.nay.redhat.com>
	 <52CFAA20.2010109@jp.fujitsu.com>
	 <20140110091433.GA14074@dhcp-16-105.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:13171 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbaAJPZX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jan 2014 10:25:23 -0500
In-Reply-To: <20140110091433.GA14074@dhcp-16-105.nay.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Baoquan <bhe@redhat.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, tangchen@cn.fujitsu.com, linux-acpi@vger.kernel.org, zhangyanfei@cn.fujitsu.com, dyoung@redhat.com

On Fri, 2014-01-10 at 17:14 +0800, Baoquan wrote:
 :
> > 
> > >Otherwise, any hotplug memory which is not reserved for 2nd kernel can
> > >be parsed and need be added as hotplug memory, and add them into movable
> > >zone.
> > 
> > wrong.
> > The memory is allocated as normal zone and it is offline.

This is "logical" offline, which means that the memory is accessible,
but the 1st kernel does not use it.

> Hi,
> 
> Thanks for answering.
> 
> I am confused. Now the fact is in 1st kernel memory is reserved for
> crashkernel and passed to 2nd kernel by exactmap. Then in 2nd kernel,
> reserved memory regions are added into e820.

Right.  And this memory is accessible.  

>  Later hotplug memory still
> trigger add_memory, and cause bug I reported.

This is because the 2nd kernel gets all memory ranges from ACPI without
your change.  This is bad, not only it causes the panic you reported but
also it can overwrite the 1st kernel's memory.

Thanks,
-Toshi

