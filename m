From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: add input device support to hotkey subdriver
Date: Sun, 15 Jul 2007 22:04:05 +0100
Message-ID: <20070715210405.GA6216@srcf.ucam.org>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223334107-git-send-email-hmh@hmh.eng.br> <20070714223144.GA25782@srcf.ucam.org> <20070715181233.GG14134@khazad-dum.debian.net> <20070715184519.GD3235@srcf.ucam.org> <20070715200338.GB19066@khazad-dum.debian.net> <20070715201201.GA5518@srcf.ucam.org> <20070715205934.GF19066@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:39227 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbXGOVER (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2007 17:04:17 -0400
Content-Disposition: inline
In-Reply-To: <20070715205934.GF19066@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Sun, Jul 15, 2007 at 05:59:34PM -0300, Henrique de Moraes Holschuh wrote:

> *HAL* does.  HAL is *not* all there is to userspace.  The input layer is not
> an interface between the kernel and HAL, it is an interface between kernel
> and userspace.

Hal is the only piece of userspace that knows how to speak to more than 
one type of backlight in any useful way, which makes it the de-facto 
reference for how userspace interprets these keys.

> Add that knowledge to the input layer, and I will agree.  Add it to every
> consumer of input events, and I will concede.  Until then, it is good that
> HAL can overcome the lack of such information in the input layer, but that
> doesn't make it the right way to use the input layer.

The fact that keys share event codes doesn't mean that these keycodes 
are going to have identical semantics on all hardware. One solution to 
that would be to avoid ever sending these keycodes, but that would make 
having them defined in the first place a bit silly. Since they /are/ 
there, it makes sense to use them.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
