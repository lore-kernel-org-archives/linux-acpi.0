From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [Pcihpd-discuss] Re: [PATCH 0/7] acpiphp - slots management fix
Date: Fri, 10 Feb 2006 11:28:24 -0800
Message-ID: <1139599704.26632.53.camel@whizzy>
References: <87acdrp5y9.wl%muneda.takahiro@jp.fujitsu.com>
	 <20060127041425.GA20453@kroah.com>
	 <87slr7k8qi.wl%muneda.takahiro@jp.fujitsu.com>
	 <20060129034502.GA7168@kroah.com> <1138731618.18768.5.camel@whizzy>
	 <20060207201304.GA18648@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:50643 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751311AbWBJTYK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Feb 2006 14:24:10 -0500
In-Reply-To: <20060207201304.GA18648@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, pavel@ucw.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org, len.brown@intel.com

On Tue, 2006-02-07 at 12:13 -0800, Greg KH wrote:
> On Tue, Jan 31, 2006 at 10:20:18AM -0800, Kristen Accardi wrote:
> > Just reviewing them, they seem like they will be fine to me.
> 
> This conflicts with your other patch you sent me.  I'll keep yours, and
> drop this one, and let you merge his in with yours.
> 
> Is that ok?
> 
> thanks,
> 
> greg k-h

I tried to merge this in against 2.6.16-rc2-mm1, which contains the
patch you kept, and there are compile issues in his patch still.  I
think it would be best if Muneda merged these himself.

Kristen


