From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Support Fujitsu Lifebook S6410 in fujitsu-laptop
Date: Mon, 14 Apr 2008 21:03:01 +0200
Message-ID: <1208199781.1784.111.camel@queen.suse.de>
References: <20080305030147.GA25310@earth.gruber.myown>
	 <1207784442.32532.0.camel@earth.gruber.myown>
	 <1208103760.19605.5.camel@earth.gruber.myown>
	 <1208169984.1784.37.camel@queen.suse.de>
	 <1208193500.11305.17.camel@earth.gruber.myown>
	 <1208195761.1784.95.camel@queen.suse.de>
	 <1208197360.11305.33.camel@earth.gruber.myown>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37723 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbYDNTDE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 15:03:04 -0400
In-Reply-To: <1208197360.11305.33.camel@earth.gruber.myown>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: linux-acpi@vger.kernel.org

On Mon, 2008-04-14 at 20:22 +0200, nokos@gmx.net wrote:
> Am Montag, den 14.04.2008, 19:56 +0200 schrieb Thomas Renninger:
> > On Mon, 2008-04-14 at 19:18 +0200, nokos@gmx.net wrote:
> > > Am Montag, den 14.04.2008, 12:46 +0200 schrieb Thomas Renninger:
> > > > >  
> > > > > +static int get_irb(void)
> > > > > +{
> > > > > +	unsigned long state = 0;
> > > > > +	acpi_status status = AE_OK;
> > > > > +
> > > > > +	status =
> > > > > +	    acpi_evaluate_integer(fujitsu->acpi_handle_e3, "GIRB", NULL,
> > > > > +				  &state);
> > > > This is ugly, but often done/needed in vendor specific ACPI drivers.
> > > > Guessing the used functions by trial and error...
> > > > Have a closer look whether there are more "upper level" functions you
> > > > could use to access the same info which might stay stable for this
> > > > specific fujitsu device.
> > > > Same for other functions below.
> > > 
> > > looking through the DSDT it is only use in the S002 function and this
> > > one is only used in FUNC (which seems to be some kind of frontend for
> > > all the S000 - S009 functions with even more cryptic parameters, ie.
> > > FUNC(0x1002,1,0,0) is the same as GIRB())
> > > 
> > > The other functions used are SBL2, which is the same as SBLL except the
> > > 	Method (SBLL, 1, NotSerialized)
> > > 	{
> > > 		If (NGTF)
> > > 		{
> > > 			Store (Arg0, LSBL)
> > > 			Return (Zero)
> > > 		}
> > > ...
> > > clause which seems to stop SBLL from working and GBLS which is a variant of GBLL with similar problem.
> > > The whole point of the parameter use_alt_lcd_levels was to have an easy way to switch between
> > > SBLL/GBLL (not working on S6410) and SBL2/GBLS (working on S6410)
> > 
> > Hmm, you mean because NGTF has another value on your machine?
> > Trying to get this solved automatically would be great...
> 
> I have not yet tried to readout the NGTF with a platform device. Hmm,
> how do access fields like NGTF (All I have done so far was calling
> functions like GBLL() and examining the return value). 
> 
> According to the DSDT should FUNC(0x1004,1,4,0) switch off NGTF, but
> then SBLL is still not working. 
I hoped NGTF is accessed somewhere else?
Maybe in some kind of initializing function or whatever...

> 
> Where can I find some documentation of the DSL/ASL language? Are there
> docs about the linux-acpi interface?
> 
> > I know there is an asus_acpi driver mailing list, I do not know about a
> > Fujitu one.
> > 
> > I do not have that much time currently, if you like I can go through the
> > code again after you split it into two parts.
> > Then it should be much easier to read...
> 
> already done ... will test it bit and then post it here.
> 
> > IMO we should also document our thinking, maybe not on a mailing list,
> > but more on bugzilla.kernel.org.
> > Then other Fujitsu users may show up testing or providing more DSDTs
> > etc. and at after some code iterations Len might accept a new Fujitsu
> > driver.
> 
> should I open a bug "fujitsu-laptop not working on S6410" or something
> for further discussions?
This sounds like a good a idea.
Maybe a second eye on the acpi tables finds something to simplify the
brightness code.

   Thomas

> > Not sure whether it's worth it, but possibly a fujitsu ACPI mailinglist
> > on sourcefore or elsewhere might be worth it (but expect some amount of
> > work...). Maybe you the author of the other fujitsu driver or others are
> > willing to help...
> > 
> > I wonder whether you have fan problems?
> > I recently found this (probably older?) fujitsu bug:
> > http://bugzilla.kernel.org/show_bug.cgi?id=8049
> 
> no, fan works as expected although I have no controls in /proc/acpi/fan/


