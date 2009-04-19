From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] eee-laptop: Register as a pci-hotplug device
Date: Sun, 19 Apr 2009 16:13:07 +0100
Message-ID: <20090419151306.GA15048@srcf.ucam.org>
References: <alpine.LFD.2.00.0902081251090.3048@localhost.localdomain> <gemini.ket9w800w44dc0hvg.linux@youmustbejoking.demon.co.uk> <20090209234911.GB862@elte.hu> <5030E21460%linux@youmustbejoking.demon.co.uk> <20090210150431.GA26798@srcf.ucam.org> <5030E7CFF4%linux@youmustbejoking.demon.co.uk> <20090419015614.GA6926@srcf.ucam.org> <71cd59b00904190020x7d946c29w736d89fc27d39594@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38238 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbZDSPNL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Apr 2009 11:13:11 -0400
Content-Disposition: inline
In-Reply-To: <71cd59b00904190020x7d946c29w736d89fc27d39594@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Darren Salt <linux@youmustbejoking.demon.co.uk>

On Sun, Apr 19, 2009 at 09:20:07AM +0200, Corentin Chary wrote:

> Hi,
> This patch conflict with
> http://git.iksaif.net/?p=acpi4asus.git;a=commitdiff;h=8082f39bb3d4a27c7bb03a76e72c70c86d55117b;hp=7ec0a7290797f57b780f792d12f4bcc19c83aa4f
> A quick fix is to do :
> 
> eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
> eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");
> if (ehotk->hotplug_slot)
>       pci_hp_deregister(ehotk->hotplug_slot);
> 
> but I'm not sure it's correct.
> I should have sent a series sooner to avoid that :/

Ok - I'll grab that and rediff.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
