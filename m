From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI suspend: Blacklist HP xw4600 Workstation for old code ordering
Date: Wed, 15 Oct 2008 15:15:26 +0100
Message-ID: <20081015141526.GA5633@srcf.ucam.org>
References: <200810142254.07024.rjw@sisk.pl> <20081015085809.GA1061@srcf.ucam.org> <200810151605.35883.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758805AbYJOOPx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200810151605.35883.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, John Brown <john.brown3@hp.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 15, 2008 at 04:05:35PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, 15 of October 2008, Matthew Garrett wrote:
> > I think trying to work out what would be more useful than just adding it to
> > a blacklist. 
> 
> Well, machines that require the "old" ordering are simply broken, because
> you just can't assume that specific devices are not in D3 before you
> execute _PTS.
> 
> IOW, we aren't doing anything wrong and the BIOS is buggy.

So how does Windows cope with this?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
