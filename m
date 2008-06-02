From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 01/15] serial: when guessing, check only active resources, not options
Date: Mon, 2 Jun 2008 09:21:02 -0600
Message-ID: <200806020921.04350.bjorn.helgaas@hp.com>
References: <20080530224853.976744229@ldl.fc.hp.com> <20080530224931.549456692@ldl.fc.hp.com> <4842FB89.6040802@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754776AbYFBPVU@vger.kernel.org>
In-Reply-To: <4842FB89.6040802@keyaccess.nl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Sunday 01 June 2008 01:42:01 pm Rene Herman wrote:
> We used to cry "modem" if the device _could_ be configured using a COM 
> address while after this change we'd only do so if it _was_ configured 
> using one.
> 
> My old analog modem for example had 5 dependent sets -- the first with 
> the regular COM port addresses (0x3f8, 0x2f8, 0x3e8, 0x2e8) and a 5th 
> one listing a port range of (IIRC, something like that at least) 0x100 
> to 0xff8.
> 
> So say I'd have a PC with the regular two onboard COM ports at COM1 and 
> COM2 (0x3f8 and 0x2f8) and an additional serial controller providing 
> COM3 and COM4 (0x3e8 and 0x2e8). My modem would then be configured to 
> use 0x100 and this code would no longer trigger while it did use to.

Ah, you're right.  That scenario hadn't occurred to me.  Let me see
if I can figure out a way to make that work again.

Bjorn
