From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
	them
Date: Sun, 25 Apr 2010 19:59:57 +0100
Message-ID: <20100425185957.GA29300@srcf.ucam.org>
References: <1272062884.1594.73.camel@laptop> <20100424160114.GA13867@srcf.ucam.org> <1272142178.1839.138.camel@laptop> <20100424211601.GA16731@srcf.ucam.org> <1272154109.1839.345.camel@laptop> <20100425022832.GA27607@khazad-dum.debian.net> <1272220091.1274.94.camel@laptop> <20100425184405.GA29130@srcf.ucam.org> <1272221872.1640.22.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58592 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab0DYTAC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Apr 2010 15:00:02 -0400
Content-Disposition: inline
In-Reply-To: <1272221872.1640.22.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On Sun, Apr 25, 2010 at 01:57:52PM -0500, Jerone Young wrote:
> On Sun, 2010-04-25 at 19:44 +0100, Matthew Garrett wrote:
> > This really isn't a problem. We have a mixer device for the Thinkpad's 
> > own mixer, and we can send ALSA events to indicate that its state has 
> > changed.
> 
> I think it is. Since pulse audio only pay attention to the Master mixer
> of the primary card. The Thinkpad EC shows up basically as a second
> audio card. 

Good thing we have the source code to pulse, then.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
