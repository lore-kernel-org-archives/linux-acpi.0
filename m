From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] toshiba-acpi: Support TOS1900-type devices
Date: Tue, 31 Mar 2009 23:11:07 +0100
Message-ID: <20090331221107.GA30383@srcf.ucam.org>
References: <20090331214501.GC29489@srcf.ucam.org> <20090331214749.GD29489@srcf.ucam.org> <74962ea30903311506m41306659td0cd70c5736f6660@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932152AbZCaWLc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <74962ea30903311506m41306659td0cd70c5736f6660@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Azael Avalos <coproscefalo@gmail.com>
Cc: linux-acpi@vger.kernel.org, dsilvers@simtec.co.uk, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org, lenb@intel.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 01, 2009 at 03:06:12PM +1700, Azael Avalos wrote:

> Indeed, my Satellite X205-9800 uses that method, however, it only provides
> HCI call 0x001E (Hotkey Events) and no System Event FIFO (0x0016),
> instead, hotkeys are entered on a variable called TOHK (TOshiba HotKeys?).
> Located in my model in
> 
> PCI0.LPCB.EC0.TOHK

Ok, interesting. Looking at the DSDTs I have here, TOHK isn't always 
present on TOS1900 devices. However:

> and it appears that it can be _polled_ tru' method INFO
> (TOSH_INTERFACE_2 ".INFO"),
> perhaps a small change in the polling to reflect to that method for
> TOS1900 devices would be necessary.

The INFO method is, so this looks like a good call.

> 
> On my model the complete call would be:
> 
> \\_SB.VALZ.SPFC
> \\_SB.VALZ.INFO
> 
> Is it different from \\_SB_.VALZ.SPFC or it simply doesn't matter?

Yeah, that shouldn't matter. So it simply looks like in the notification 
function on these systems we should call the INFO method and that'll 
give us the key back? I'll send a test patch later (don't have any 
hardware to test right now).

-- 
Matthew Garrett | mjg59@srcf.ucam.org
