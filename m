From: Shaohua Li <shaohua.li@intel.com>
Subject: RE: one more ACPI Error (utglobal-0125): Unknown exception
	code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Thu, 07 Sep 2006 10:03:44 +0800
Message-ID: <1157594624.2782.45.camel@sli10-desk.sh.intel.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com>
	 <1157573069.5713.24.camel@keithlap>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18722 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1422637AbWIGCHf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Sep 2006 22:07:35 -0400
In-Reply-To: <1157573069.5713.24.camel@keithlap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kmannth@us.ibm.com
Cc: "Moore, Robert" <robert.moore@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

On Thu, 2006-09-07 at 04:04 +0800, keith mannthey wrote:
> On Wed, 2006-09-06 at 11:59 -0700, Moore, Robert wrote: 
> > From one of the ACPI guys: 
> >  
> > > Get hid 
> > > Look for driver 
> > > If you find a match, load it 
> > > If no match, get CID 
> > > Look for driver 
> > > If you find a match, load it 
> > > If you did not find an hid or cid match, punt
> 
> I think this is what my patch is doing.
> 
> when looking for a driver: (acpi_bus_find_driver) 
> I check against the HID  
> return if found  
> Then I check against the CID 
> return if found 
> else 
> punt 
> 
> Any objections to pushing this into -mm and dropping the motherboard 
> change?
I'd prefer not take this way. The ACPI driver model is already mess
enough, let's don't make it worse. We are converting the ACPI driver
model to Linux driver model, this will make the attempt difficult.

We can let the motherboard driver not bind to your device (say we didn't
register the motherboard driver, but just reserve the resource of the
deivce). Is it ok to you? (I remember Bjorn said he wants to reserve the
mem region of the device too).

Thanks,
Shaohua
