From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ltp] Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Tue, 10 Nov 2009 14:14:06 +0000
Message-ID: <20091110141406.GB19792@srcf.ucam.org>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com> <20091109165420.GA28672@srcf.ucam.org> <cb0375e10911090949o4a51cfd5x4f896d983398a7bc@mail.gmail.com> <20091109175416.GA29887@srcf.ucam.org> <20091110092418.GC1872@khazad-dum.debian.net> <cb0375e10911100532l484e69aeyd78e422c23d730ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51060 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbZKJOOO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2009 09:14:14 -0500
Content-Disposition: inline
In-Reply-To: <cb0375e10911100532l484e69aeyd78e422c23d730ce@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Nov 10, 2009 at 08:32:17AM -0500, Andrew Lutomirski wrote:

> What's the point of the IBM mixer (/proc/acpi/ibm/volume)?  We have a
> perfectly good mixer in the form of ALSA, which already knows how to
> mute and unmute the sound and even comes with nice user interfaces
> these days.

I posted a patch a while back that adds ALSA mixer support to the 
Thinkpad driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
