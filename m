From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver v0.94
Date: Fri, 4 Jul 2008 13:11:16 +0100
Message-ID: <20080704121116.GA11510@srcf.ucam.org>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080704034419.GG4381@prithivi.gnumonks.org> <20080704091031.GA8905@srcf.ucam.org> <20080704120754.GC7435@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53031 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbYGDMLV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jul 2008 08:11:21 -0400
Content-Disposition: inline
In-Reply-To: <20080704120754.GC7435@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Harald Welte <laforge@gnumonks.org>, linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>

On Fri, Jul 04, 2008 at 09:07:54AM -0300, Henrique de Moraes Holschuh wrote:

> Unless someone posts a recipe here of how to get HAL to connect to an input
> device, and how to tell it to run code when a KEY_* event is received (which
> you could add to the driver documentation), I'd say proc_generate_event will
> have to be tolerated.  It is all most people know how to deal with in
> userspace.

hal has bound to input devices for years. It won't run code directly, 
since that's a policy decision, but lshal -m should show events come 
from input devices.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
