From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.25-rc1 regression - IBM ACPI backlight
Date: Fri, 15 Feb 2008 09:50:30 -0200
Message-ID: <20080215115030.GA27836@khazad-dum.debian.net>
References: <20080214103801.GB4366@ics.muni.cz> <20080214122452.GB12775@khazad-dum.debian.net> <20080215110213.GA5648@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757554AbYBOLut@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080215110213.GA5648@ics.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 15 Feb 2008, Lukas Hejtmanek wrote:
> On Thu, Feb 14, 2008 at 10:24:52AM -0200, Henrique de Moraes Holschuh wrote:
> > > as of 2.6.25-rc1, there is no more /sys/class/backlight/acpi_video1 which
> > > controlled LVDS backlight on Lenovo ThinkPad T61. There is still
> > > acpi_video0 which seems to have sane values but echo N > brightness has no
> > > effect at all.
> > > 
> > > thinkpad_acpi module reports that ACPI controlled backlight is present.
> > 
> > Please report this to linux-acpi @ vger . kernel . org...
> > 
> > It is likely caused by the stuff to locate and disable the unused video
> > device in the DSDT (apparently it got the wrong device?!).
> > 
> > However, BEFORE reporting to linux-acpi, please test it in single user mode
> > without X *ever* being loaded on that boot.  New X disables the BIOS
> > brightness changes that ACPI uses.
> 
> 2.6.24 kernel has two acpi_video[01]. 2.6.25-rc1 does not, it contains only
> acpi_video0 (even in text mode in single user without X being loaded) which
> does not work at all.

The thinkpad DSDT exports two acpi video nodes, but only one is active.
Apparently, ACPI video chose the wrong one.  You did the test by booting
directly to single user mode (without X loading at all since the last
reboot), correct?  That means there is a bug to report, indeed.

Please report it through http://buzilla.kernel.org, as that's the preferred
method of bug reporting by the ACPI people.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
