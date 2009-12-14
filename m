From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH]acpi c-states: Fix ACPI C3 is wrongly mapped to C2
Date: Mon, 14 Dec 2009 09:13:50 +0100
Message-ID: <20091214081350.GA19266@dominikbrodowski.net>
References: <20091212181442.GA22832@youquan-linux.bj.intel.com>
 <20091212142727.GA6867@comet.dominikbrodowski.net>
 <20091212235549.GA7753@youquan-linux.bj.intel.com>
 <20091213084317.GA15989@isilmar.linta.de>
 <20091214100200.GA17243@youquan-linux.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:34657 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750910AbZLNIQ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Dec 2009 03:16:28 -0500
Content-Disposition: inline
In-Reply-To: <20091214100200.GA17243@youquan-linux.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Youquan,Song" <youquan.song@linux.intel.com>
Cc: lenb@kernel.org, venkatesh.pallipadi@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, youquan.song@intel.com, linux-acpi@vger.kernel.org

Hey,

On Mon, Dec 14, 2009 at 05:02:00AM -0500, Youquan,Song wrote:
> > > That's true, if CPU has more 3 states such as C3, C6, C7, there are
> > > all mapped to ACPI C3.   But the current situation is that if platform
> > > does NOT support ACPI C2, the user interface /sys show us ACPI C2 is
> > >  supported which actual is ACPI C3.
> > > 
> > > As you know, ACPI C3 and ACPI C2 have much different, such as: BUS SNOOP
> > >  or not, ACPI C3 has better power saving etc. we should not mix them.
> > 
> > Yes, but what happens if there are two states of type C2? The whole concept
> > of "type C<number>" and "state C<number>" was broken from the beginning...
> 
> Sorry. In my mind, there is no two states of ACPI C2. If processor C3
> above are mapped to ACPI C3, so processor C1 is mapped to ACPI C1,
> processor C2 is mapped to ACPI C2.  

Well, there may be none now, but the ACPI spec 4.0 provides for it in section
8.1.5... The whole mapping of ACPI C-state Types to C-state numbers _is_
confusing.

Best,
	Dominik
