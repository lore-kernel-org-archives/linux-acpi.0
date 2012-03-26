From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Implement overriding of arbitrary ACPI tables via initrd
Date: Mon, 26 Mar 2012 16:51:29 +0200
Message-ID: <201203261651.29640.trenn@suse.de>
References: <1332512984-79664-1-git-send-email-trenn@suse.de> <201203261619.31766.trenn@suse.de> <4F70812A.4080205@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F70812A.4080205@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: eric.piel@tremplin-utc.net, vojcek@tlen.pl, dsdt@gaugusch.at, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Lin Ming <ming.m.lin@intel.com>, lenb@kernel.org, robert.moore@intel.com, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-acpi@vger.kernel.org

On Monday, March 26, 2012 04:46:02 PM H. Peter Anvin wrote:
> On 03/26/2012 07:19 AM, Thomas Renninger wrote:
> > Do the names have to be fixed?
> 
> No, I assume it would "all files inside this namespace".
> 
> > If there is only one file where all ACPI table binaries are glued
> > together kernel/acpi_tables.binary.blob
> > my code should already work as good as unmodified.
> > 
> > Not sure what is best and whether anybody cares about how the tables
> > are layed out.
> > 
> > I guess I just wait until your functionality is in linux-next and
> > give it a closer look then and may come up with a new patch.
> 
> I doubt it will get into linux-next without a user.  If you have time to
> pull in the code I sent it will be quicker, otherwise I'll probably
> setup a git tree upon which things can be put.

I need some weeks to have time to revisit this.
But as it slips this merge window anyway it should not matter.
Please add me to CC if someone else looks at or goes on with this.

  Thomas
