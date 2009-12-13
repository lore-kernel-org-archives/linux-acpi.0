From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH]acpi c-states: Fix ACPI C3 is wrongly mapped to C2
Date: Sun, 13 Dec 2009 09:43:17 +0100
Message-ID: <20091213084317.GA15989@isilmar.linta.de>
References: <20091212181442.GA22832@youquan-linux.bj.intel.com> <20091212142727.GA6867@comet.dominikbrodowski.net> <20091212235549.GA7753@youquan-linux.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:44782 "HELO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751795AbZLMInT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Dec 2009 03:43:19 -0500
Content-Disposition: inline
In-Reply-To: <20091212235549.GA7753@youquan-linux.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Youquan,Song" <youquan.song@linux.intel.com>
Cc: lenb@kernel.org, venkatesh.pallipadi@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, youquan.song@intel.com, linux-acpi@vger.kernel.org

On Sat, Dec 12, 2009 at 06:55:49PM -0500, Youquan,Song wrote:
> On Sat, Dec 12, 2009 at 03:27:27PM +0100, Dominik Brodowski wrote:
> > On Sat, Dec 12, 2009 at 01:14:42PM -0500, Youquan,Song wrote:
> > > On Nehalem-EX, CPU C3 is mapped to ACPI C3, but C-states information in /proc
> > >  and /sys are conflicting with ACPI C2 mapping and confused user.
> > 
> > Well, isn't the "type" only losely related to the C-state number anyway, if
> > you have more than 3 states?
> 
> That's true, if CPU has more 3 states such as C3, C6, C7, there are
> all mapped to ACPI C3.   But the current situation is that if platform
> does NOT support ACPI C2, the user interface /sys show us ACPI C2 is
>  supported which actual is ACPI C3.
> 
> As you know, ACPI C3 and ACPI C2 have much different, such as: BUS SNOOP
>  or not, ACPI C3 has better power saving etc. we should not mix them.

Yes, but what happens if there are two states of type C2? The whole concept
of "type C<number>" and "state C<number>" was broken from the beginning...

Best,
	Dominik
