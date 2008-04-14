From: nokos@gmx.net
Subject: Re: [PATCH] ACPI: Support Fujitsu Lifebook S6410 in fujitsu-laptop
Date: Mon, 14 Apr 2008 20:00:59 +0200
Message-ID: <1208196059.11305.18.camel@earth.gruber.myown>
References: <20080305030147.GA25310@earth.gruber.myown>
	 <1207784442.32532.0.camel@earth.gruber.myown>
	 <1208103760.19605.5.camel@earth.gruber.myown>
	 <1208169984.1784.37.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:43272 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757984AbYDNSB3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 14:01:29 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 1F9732BBF39
	for <linux-acpi@vger.kernel.org>; Mon, 14 Apr 2008 20:01:26 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 03A302130A2
	for <linux-acpi@vger.kernel.org>; Mon, 14 Apr 2008 20:01:26 +0200 (CEST)
Received: from [0.0.0.0] (dslb-084-056-092-007.pools.arcor-ip.net [84.56.92.7])
	(Authenticated sender: nokos@arcor.de)
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 9C6671A32E6
	for <linux-acpi@vger.kernel.org>; Mon, 14 Apr 2008 20:01:19 +0200 (CEST)
Received: from 127.0.0.1 (ident=2vYyKroknlp) by earth.gruber.myown with
 esmtp (masqmail 0.2.21) id 1JlSzE-0jK-00 for
 <linux-acpi@vger.kernel.org>; Mon, 14 Apr 2008 20:01:00 +0200
In-Reply-To: <1208169984.1784.37.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Am Montag, den 14.04.2008, 12:46 +0200 schrieb Thomas Renninger:
> >  
> > +static int get_irb(void)
> > +{
> > +	unsigned long state = 0;
> > +	acpi_status status = AE_OK;
> > +
> > +	status =
> > +	    acpi_evaluate_integer(fujitsu->acpi_handle_e3, "GIRB", NULL,
> > +				  &state);
> This is ugly, but often done/needed in vendor specific ACPI drivers.
> Guessing the used functions by trial and error...
> Have a closer look whether there are more "upper level" functions you
> could use to access the same info which might stay stable for this
> specific fujitsu device.
> Same for other functions below.

looking through the DSDT it is only use in the S002 function and this
one is only used in FUNC (which seems to be some kind of frontend for
all the S000 - S009 functions with even more cryptic parameters, ie.
FUNC(0x1002,1,0,0) is the same as GIRB())

The other functions used are SBL2, which is the same as SBLL except the
	Method (SBLL, 1, NotSerialized)
	{
		If (NGTF)
		{
			Store (Arg0, LSBL)
			Return (Zero)
		}
...
clause which seems to stop SBLL from working and GBLS which is a variant of GBLL with similar problem.
The whole point of the parameter use_alt_lcd_levels was to have an easy way to switch between
SBLL/GBLL (not working on S6410) and SBL2/GBLS (working on S6410)

Peter

> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

