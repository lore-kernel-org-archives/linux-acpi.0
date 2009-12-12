From: "Youquan,Song" <youquan.song@linux.intel.com>
Subject: Re: [PATCH]acpi c-states: Fix ACPI C3 is wrongly mapped to C2
Date: Sat, 12 Dec 2009 18:55:49 -0500
Message-ID: <20091212235549.GA7753@youquan-linux.bj.intel.com>
References: <20091212181442.GA22832@youquan-linux.bj.intel.com> <20091212142727.GA6867@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:27097 "HELO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S933599AbZLMBgq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Dec 2009 20:36:46 -0500
Content-Disposition: inline
In-Reply-To: <20091212142727.GA6867@comet.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Youquan,Song" <youquan.song@linux.intel.com>, lenb@kernel.org, venkatesh.pallipadi@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, youquan.song@intel.com, linux-acpi@vger.kernel.org

On Sat, Dec 12, 2009 at 03:27:27PM +0100, Dominik Brodowski wrote:
> On Sat, Dec 12, 2009 at 01:14:42PM -0500, Youquan,Song wrote:
> > On Nehalem-EX, CPU C3 is mapped to ACPI C3, but C-states information in /proc
> >  and /sys are conflicting with ACPI C2 mapping and confused user.
> 
> Well, isn't the "type" only losely related to the C-state number anyway, if
> you have more than 3 states?

That's true, if CPU has more 3 states such as C3, C6, C7, there are
all mapped to ACPI C3.   But the current situation is that if platform
does NOT support ACPI C2, the user interface /sys show us ACPI C2 is
 supported which actual is ACPI C3.

As you know, ACPI C3 and ACPI C2 have much different, such as: BUS SNOOP
 or not, ACPI C3 has better power saving etc. we should not mix them.

Thanks.

-Youquan

