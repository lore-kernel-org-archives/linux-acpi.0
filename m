From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/2] mce: acpi/apei: Honour Firmware First for MCA
 banks listed in APEI HEST CMC
Date: Fri, 21 Jun 2013 19:40:57 +0200
Message-ID: <20130621174057.GI22006@pd.tnic>
References: <20130620073943.GE32694@pd.tnic>
 <51C3531D.3000600@linux.vnet.ibm.com>
 <20130620192928.GD19877@pd.tnic>
 <51C36288.4050405@linux.vnet.ibm.com>
 <20130620205726.GA20863@pd.tnic>
 <51C37291.40303@linux.vnet.ibm.com>
 <20130621073419.GC22006@pd.tnic>
 <51C404EA.10906@linux.vnet.ibm.com>
 <20130621083608.GE22006@pd.tnic>
 <CA+8MBbJkaiFhtmidBck6oiNXbzS=cUn-m2YkwWmNG+DjmtDiDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:53713 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423307Ab3FURlI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jun 2013 13:41:08 -0400
Content-Disposition: inline
In-Reply-To: <CA+8MBbJkaiFhtmidBck6oiNXbzS=cUn-m2YkwWmNG+DjmtDiDQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Huang Ying <ying.huang@intel.com>

On Fri, Jun 21, 2013 at 09:47:31AM -0700, Tony Luck wrote:
> On Fri, Jun 21, 2013 at 1:36 AM, Borislav Petkov <bp@alien8.de> wrote:
> > So ok, I'm persuaded, yet another bitfield it is ... :-\
> 
> Let's add some more comments on what each of these bitfields mean. Otherwise
> we will be going back over this next time we have a patch that touches one
> of them and we've all forgotten the subtle details explained in this
> e-mail thread.

Very good point - it's like you're reading my mind! I thought about
suggesting exactly that but then it slipped my mind with all the details
and commotion here.

:-)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
