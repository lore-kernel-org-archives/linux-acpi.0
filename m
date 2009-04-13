From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] toshiba-acpi: Add support for hotkey notifications
Date: Mon, 13 Apr 2009 22:31:51 +0100
Message-ID: <20090413213151.GA18201@srcf.ucam.org>
References: <20090331214501.GC29489@srcf.ucam.org> <200904132238.11401.elendil@planet.nl> <20090413211800.GA17922@srcf.ucam.org> <200904132326.36303.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753906AbZDMVcQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200904132326.36303.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, dsilvers@simtec.co.uk, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 13, 2009 at 11:26:34PM +0200, Frans Pop wrote:
> On Monday 13 April 2009, Matthew Garrett wrote:
> > On Mon, Apr 13, 2009 at 10:38:09PM +0200, Frans Pop wrote:
> > > On Monday 13 April 2009, Matthew Garrett wrote:
> > > > Hm. Do you get events for the multimedia keys without this patch
> > > > and using the old interface?
> > >
> > > Yes, 2.6.28 gives in /proc/acpi/toshiba/keys as value for 'hotkey':
> > > previous track:	0x0b31
> > > next track:	0x0b32
> > > play/pause:	0x0b33
> > > stop:		0x0b30
> >
> > Without running any software, does hitting these keys cause the acpi
> > interrupt in /proc/interrupts to increment?
> 
> Yes (with 2.6.28; fnfx* purged before system boot).

Ok - can you build with ACPI debugging, set /proc/acpi/debug_level and 
debug_layer to 0xffff, hit one of the keys, turn the debugging back off 
and then send me the log? Easiest is to do something like:

echo 0xffff >/proc/acpi/debug_level; echo 0xffff 
>/proc/acpi/debug_layer; sleep 3; echo 0 blah blah

so you don't have to try to disable them while stuff's appearing all 
over your screen. There'll be a lot of output, so if you could send it 
to me rather than the list then that would be great.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
