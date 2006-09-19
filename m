From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception  code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Tue, 19 Sep 2006 04:22:09 -0600
Message-ID: <200609190422.10370.bjorn.helgaas@hp.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com> <200609141036.07599.bjorn.helgaas@hp.com> <1158284395.20560.30.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:64183 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751878AbWISKWP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Sep 2006 06:22:15 -0400
In-Reply-To: <1158284395.20560.30.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: kmannth@us.ibm.com, "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

On Thursday 14 September 2006 19:39, Shaohua Li wrote:
> > PCI has a /sys/bus/pci/driver/XXX/{bind,unbind} mechanism to cause a
> > driver to release a device and bind another driver to it.  Maybe we
> > could do something similar for ACPI. 
> After we convert acpi core to Linux driver model, we have the
> capability. But not sure if this can help Keith.

When will the conversion to the Linux driver model happen?
