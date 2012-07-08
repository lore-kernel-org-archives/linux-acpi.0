From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] ACPI: Leave Bus Master Arbitration enabled for suspend/resume
Date: Sun, 8 Jul 2012 22:53:26 +0200
Message-ID: <201207082253.26971.rjw@sisk.pl>
References: <op.wg3en6ij6g6bxc@localhost.localdomain> <201207082208.19664.rjw@sisk.pl> <op.wg5ajlqi6g6bxc@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <op.wg5ajlqi6g6bxc@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Octavio Alvarez <alvarezp@alvarezp.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Bob Moore <robert.moore@intel.com>, Adrian Knoth <adi@drcomp.erfurt.thur.de>, Shaohua Li <shli@kernel.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday, July 08, 2012, Octavio Alvarez wrote:
> On Sun, 08 Jul 2012 13:08:19 -0700, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> >> This is an old suspend/resume lockup fix:
> >>
> >> 	commit 2780cc4660e1
> >> 	Author: Len Brown <len.brown@intel.com>
> >> 	Date:   Thu Dec 23 13:43:30 2004 -0500
> >>
> >> 	    [ACPI] Fix suspend/resume lockup issue
> >> 	    by leaving Bus Master Arbitration enabled.
> >> 	    The ACPI spec mandates it be disabled only for C3.
> >>
> >> The bug snuck back in in commit 2feec47d4c5f (ACPICA: ACPI 5: Support
> >> for new FADT SleepStatus, SleepControl registers, 2012-02-14),
> >> presumably by copy/pasting a copy of the code without that fix for the
> >> legacy case.
> >>
> >> On affected machines, after that commit, the machine locks up hard on
> >> resume from suspend.  The same fix as seven years ago still works.
> >>
> > Applied to the linux-next branch of the linux-pm.git tree.
> >
> > I think I'll push it for v3.6, since the bug is serious and is a  
> > regression.
> >
> > Bob, I think we should incorporate this into ACPICA, shouldn't we?
> 
> This bug affects since 3.4. I'd like to ask for this to be applied in the
> stable branches too, considering Jonathan's comments that this is a replay
> of an old and proven fix.
> 
> (I don't know if 3.3 is affected too. I know 3.2 is not affected by this.)

The problem seems to have been introduced during the 3.4 development cycle,
so v3.3 shouldn't be affected by it too.

Thanks,
Rafael
