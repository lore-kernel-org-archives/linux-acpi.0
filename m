From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module
Date: Fri, 24 Aug 2007 17:01:50 +0930 (CST)
Message-ID: <200708240731.l7O7VoEq010499@turbo.physics.adelaide.edu.au>
References: <GMail.1187940251.19909429.55227696746@brewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:41999 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750825AbXHXHcG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:32:06 -0400
In-Reply-To: <GMail.1187940251.19909429.55227696746@brewt.org> from "Adrian Yee" at Aug 24, 2007 12:24:11 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Yee <brewt-linux-acpi@brewt.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

Hi Adrian

> I was the person who cleaned up the code a couple years back.  I don't own a
> Fujitsu notebook anymore, but here's some information from what I remember.
> 
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > +static int acpi_fuj02b1_get_volume_state(void *data)
> > 
> > This probably wants to be exported as an ALSA mixer rather than a 
> > special device in /proc.
> 
> My S6010 had hardware volume control (it was separate from what was ALSA
> controlled).  I'm not sure if this is still the case with the Fujitsu's S and
> P-series notebooks.
:
> Since the buttons control the hardware volume control, I believe the events were
> more for displaying OSD volume status.

Thanks for the information.  I'll do some more tests over the next week or
so to see how this relates to the S7xxx series.  Even so, given that it was
obviously useful for the earlier series we should probably still leave it
in.

> > > +static int acpi_fuj02b1_get_pointer_state(void *data)
> > 
> > Less sure about this one, but I'm not sure exactly what it's meant to 
> > do - control whether the mouse pointer is enabled?
> 
> I never used this, but I think it gives the user the ability to disable the
> built-in touchpad.  Probably driver dependent.

Ah right - that would make more sense than disabling the hardware graphics
cursor.

Regards
  jonathan
