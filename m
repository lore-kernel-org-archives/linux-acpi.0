From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4]  Hot Dock/Undock support
Date: Wed, 18 Jan 2006 21:47:09 +0000
Message-ID: <20060118214709.GA12010@srcf.ucam.org>
References: <1137545813.19858.45.camel@whizzy> <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy> <20060118194554.GA1502@elf.ucw.cz> <1137618370.31839.12.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161014AbWARVsG@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1137618370.31839.12.camel@whizzy>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 18, 2006 at 01:06:09PM -0800, Kristen Accardi wrote:

> Hum, I don't think so (but maybe someone else knows for sure), I thought
> that driver was specifically for a certain kind of IBM server, not an
> IBM laptop.  It looks like from this output that the acpiphp is not
> recognizing any hotplug capable devices on your laptop.  I believe that
> this is defined by acpiphp as a slot which is "ejectable", meaning
> contains an ACPI method called _EJ0.  

To the best of my knowledge, the X-series docking station doesn't 
contain any PCI devices. It's an extension of the IDE bus plus some 
broken out serial, parallel, USB and so on. I'd expect driver support 
for it to just require supporting the dock object and calling its eject 
routine when the user hits the eject button.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
