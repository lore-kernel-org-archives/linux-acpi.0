From: Thomas Voegtle <tv@lio96.de>
Subject: Re: bttv card after swsusp dead
Date: Wed, 12 Oct 2005 13:59:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510121355030.30888@er-systems.de>
References: <Pine.LNX.4.63.0510112104290.16712@er-systems.de>
 <20051012113239.GA31035@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1395022924-223126574-1129118341=:30888"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932428AbVJLL7A@vger.kernel.org>
In-Reply-To: <20051012113239.GA31035@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1395022924-223126574-1129118341=:30888
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 12 Oct 2005, Pavel Machek wrote:

> Hi!
> 
> > with 2.6.13 I could after a software suspend use my bttv card. This is not 
> > possible aynmore with 2.6.14-rc3 and 2.6.14-rc4. 
> > 
> > dmesg part of 2.6.13:
> > 
> > ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKA] -> GSI 11 (level, low) 
> > -> IRQ 11
> > bttv0: reset, reinitialize
> > bttv0: PLL: 28636363 => 35468950 . ok
> > 
> > 
> > 
> > and now with 2.6.14-rc3/4:
> > 
> > 
> > ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [LNKA] -> GSI 11 (level, low) 
> > -> IRQ 11
> > ACPI: PCI interrupt for device 0000:01:04.0 disabled
> > bttv0: Can't enable device.
> > ACPI: PCI Interrupt 0000:01:04.1[A] -> Link [LNKA] -> GSI 11 (level, low) 
> > -> IRQ 11
> 
> You probably want to ask on acpi-devel. Looks like some change in
> interrupt routing broken your card..
> 
> 									Pavel


Stupid me. Herewith resend to acpi-devel. 
Thanks Pavel for the info.

 

      Thomas

-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------
---1395022924-223126574-1129118341=:30888--
