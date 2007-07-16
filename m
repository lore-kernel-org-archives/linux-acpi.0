From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: add input device support to hotkey subdriver
Date: Mon, 16 Jul 2007 16:51:03 +0100
Message-ID: <20070716155103.GB19199@srcf.ucam.org>
References: <11844223334107-git-send-email-hmh@hmh.eng.br> <20070714223144.GA25782@srcf.ucam.org> <20070715181233.GG14134@khazad-dum.debian.net> <20070715184519.GD3235@srcf.ucam.org> <20070715200338.GB19066@khazad-dum.debian.net> <20070715201201.GA5518@srcf.ucam.org> <20070715205934.GF19066@khazad-dum.debian.net> <20070715210405.GA6216@srcf.ucam.org> <20070715215453.GJ19066@khazad-dum.debian.net> <d120d5000707160846m541ddd33uccdb5387ee9ee1c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:39795 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763619AbXGPPvP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jul 2007 11:51:15 -0400
Content-Disposition: inline
In-Reply-To: <d120d5000707160846m541ddd33uccdb5387ee9ee1c3@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, Jul 16, 2007 at 11:46:26AM -0400, Dmitry Torokhov wrote:

> How do you know that this is a "passive keypress"? Can you put another
> (better) soundcard in a docking station? Woudl the firmware still
> control that card (doubtful)? Do we want the same keys to control that
> card's volume?

This is absolutely possible. In that case I'd expect the hotkeys to 
start controlling the card mixer's volume, but that's a policy decision 
that would have to be taken in userspace by an application aware of 
everything that's happened.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
