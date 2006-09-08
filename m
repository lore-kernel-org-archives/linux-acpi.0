From: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception
     code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Thu, 7 Sep 2006 20:27:59 -0600 (MDT)
Message-ID: <4132.24.9.204.52.1157682479.squirrel@mail.cce.hp.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com>
    <1157573069.5713.24.camel@keithlap>
    <1157594624.2782.45.camel@sli10-desk.sh.intel.com>
    <200609070925.50145.bjorn.helgaas@hp.com>
    <1157677028.2782.64.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ccerelrim02.cce.hp.com ([161.114.21.23]:56869 "EHLO
	ccerelrim02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1752039AbWIHC2C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Sep 2006 22:28:02 -0400
In-Reply-To: <1157677028.2782.64.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, kmannth@us.ibm.com, "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

> On Thu, 2006-09-07 at 09:25 -0600, Bjorn Helgaas wrote:
>> If we decide that "try HID first, then try CID" is the right thing,
>> I think we should figure out how to make that work.  Maybe that
>> means extending the driver model somehow.
> Don't think it's easy, especially no other bus needs it I guess.

I agree it's probably not easy, but I think having the right
semantics is more important than fitting cleanly into the
driver model.  But I know that without code, I'm just venting
hot air, not contributing to a solution.

How's the ACPI driver model integration going, anyway?  I seem
to recall some patches a while back, but I don't think they're
in the tree yet.

> Do we really need the memory hotplug device returns pnp0c01/pnp0c02?
> What's the purpose?

I don't know.  But I think Keith already determined that a BIOS change
is not likely.  I hate to ask for BIOS changes like this because it
feels like asking them to avoid broken things in Linux.

