From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
	them
Date: Sun, 25 Apr 2010 19:44:05 +0100
Message-ID: <20100425184405.GA29130@srcf.ucam.org>
References: <1272062884.1594.73.camel@laptop> <20100424160114.GA13867@srcf.ucam.org> <1272142178.1839.138.camel@laptop> <20100424211601.GA16731@srcf.ucam.org> <1272154109.1839.345.camel@laptop> <20100425022832.GA27607@khazad-dum.debian.net> <1272220091.1274.94.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57527 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab0DYSoL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Apr 2010 14:44:11 -0400
Content-Disposition: inline
In-Reply-To: <1272220091.1274.94.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

On Sun, Apr 25, 2010 at 01:28:11PM -0500, Jerone Young wrote:

> I think it's not really possible to get it correct with thinkpad-acpi .
> The reason is the userspace sound server. In our case it's pulse audio.
> So we are no longer just dealing with ALSA anymore. So if the OS gets a
> proper hotkey event it is able to mute at the pulse audio level then,
> pulse audio does work at the ALSA level (toggling the mixer).
> thinkpad-acpi has no way to check on the status of pulse audio.

This really isn't a problem. We have a mixer device for the Thinkpad's 
own mixer, and we can send ALSA events to indicate that its state has 
changed.
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
