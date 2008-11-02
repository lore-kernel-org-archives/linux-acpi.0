From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: eeepc-laptop rfkill, stupid question #4 and 5
Date: Sun, 2 Nov 2008 01:46:20 -0200
Message-ID: <20081102034620.GA29606@khazad-dum.debian.net>
References: <490B3BB5.8060801@tuffmail.co.uk> <20081031171126.GA17313@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753709AbYKBDqi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081031171126.GA17313@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 31 Oct 2008, Matthew Garrett wrote:
> > Actually, normal boot doesn't preserve the setting either.  Your commit
> > changes the behaviour from the rfkill state being persistent across
> > reboot / power off (as a bios setting), to being always enabled on
> > boot.  It seems like a bad idea to me.
> 
> This is the behaviour of the rfkill core.

When you don't use rfkill_set_default().  Which, if you are a platform
driver, and your platform can store state across power off, you should use.

Yeah, it is a new thing, sort of. But it is in mainline already, so feel
free to use it.  The right way to do it is to call it BEFORE doing any
rfkill_register or rfkill_allocate.  Only the first caller for a given
rfkill type, wins.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
