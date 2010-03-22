From: Chris Vine <chris@cvine.freeserve.co.uk>
Subject: Re: Suspend/hibernate wireless regression with 2.6.33 kernel
Date: Mon, 22 Mar 2010 21:21:02 +0000
Message-ID: <20100322212102.751099ee@boulder.homenet>
References: <20100317015113.4e833e1c@boulder.homenet>
	<20100322122517.1743e896@boulder.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100322122517.1743e896@boulder.homenet>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-acpi@vger.kernel.org

On Mon, 22 Mar 2010 12:25:17 +0000
Chris Vine <chris@cvine.freeserve.co.uk> wrote:
> On Wed, 17 Mar 2010 01:51:13 +0000
> Chris Vine <chris@cvine.freeserve.co.uk> wrote:
> > Hi,
> > 
> > I have a Lenovo S12 (Ideapad) netbook with a BCM4312 802.11b/g
> > [14e4:4315] wireless device.  Although this works using the PIO
> > option in kernel 2.6.33/2.6.33.1 (not with DMA) using the in-kernel
> > b43 driver, and also works with the broadcom proprietary wl driver,
> > it breaks after a suspend or hibernate. Attempts to bring up the
> > wlan0 interface with 'ifconfig wlan0 up' after suspension or
> > hibernation results in the following message (although nothing is
> > revealed by dmesg):
> > 
> >   SIOCSIFFLAGS: Unknown error 132
> > 
> > More worryingly, when suspending or hibernating, acpi sometimes
> > but not always appears to write to the CMOS.  On two occasions I
> > have observed that although a reboot into 2.6.33 would work (until
> > there is another suspension or hibernation), wireless becomes
> > permanently switched off when rebooting into 2.6.32 or earlier -
> > when reading from the BIOS, kernel 2.6.32 and below appears to
> > think that the radio has been disabled even though the BIOS set-up
> > screen disagrees. When this occurs, I have to restore all defaults
> > in the BIOS to get wireless to come on again in kernel 2.6.32 and
> > less.
> 
> [snip]
> 
> This regression between 2.6.32 and 2.6.33 is still present in
> 2.6.34-rc2, with an added twist.  In 2.6.34-rc2, on resuming from
> suspension or hibernation, my rfkill button is completely disabled -
> that is, I cannot switch wireless on, but I also cannot switch
> bluetooth off.

I have found the proximate cause of this.  From version 2.6.33, at boot
time the acer-wmi module gets loaded.  As this is a Lenovo netbook
and not an Acer laptop, and probably uses a different chipset, that is
not a good thing to do.

If I blacklist acer-wmi, then suspension and hibernation appears to
work normally.

Chris
