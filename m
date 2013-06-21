From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH v2 1/2] mce: acpi/apei: Honour Firmware First for MCA
 banks listed in APEI HEST CMC
Date: Fri, 21 Jun 2013 09:47:31 -0700
Message-ID: <CA+8MBbJkaiFhtmidBck6oiNXbzS=cUn-m2YkwWmNG+DjmtDiDQ@mail.gmail.com>
References: <20130619175438.2852.93449.stgit@localhost.localdomain>
	<20130620073943.GE32694@pd.tnic>
	<51C3531D.3000600@linux.vnet.ibm.com>
	<20130620192928.GD19877@pd.tnic>
	<51C36288.4050405@linux.vnet.ibm.com>
	<20130620205726.GA20863@pd.tnic>
	<51C37291.40303@linux.vnet.ibm.com>
	<20130621073419.GC22006@pd.tnic>
	<51C404EA.10906@linux.vnet.ibm.com>
	<20130621083608.GE22006@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:64011 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161494Ab3FUQrc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jun 2013 12:47:32 -0400
In-Reply-To: <20130621083608.GE22006@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Huang Ying <ying.huang@intel.com>

On Fri, Jun 21, 2013 at 1:36 AM, Borislav Petkov <bp@alien8.de> wrote:
> So ok, I'm persuaded, yet another bitfield it is ... :-\

Let's add some more comments on what each of these bitfields mean. Otherwise
we will be going back over this next time we have a patch that touches one
of them and we've all forgotten the subtle details explained in this
e-mail thread.

-Tony
