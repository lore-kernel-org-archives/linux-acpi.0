From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver v0.94
Date: Fri, 4 Jul 2008 13:33:12 +0100
Message-ID: <20080704123312.GA11829@srcf.ucam.org>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080704034419.GG4381@prithivi.gnumonks.org> <20080704091031.GA8905@srcf.ucam.org> <20080704120754.GC7435@khazad-dum.debian.net> <20080704121116.GA11510@srcf.ucam.org> <20080704122247.GF7435@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46557 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbYGDMdR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jul 2008 08:33:17 -0400
Content-Disposition: inline
In-Reply-To: <20080704122247.GF7435@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Harald Welte <laforge@gnumonks.org>, linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>

On Fri, Jul 04, 2008 at 09:22:47AM -0300, Henrique de Moraes Holschuh wrote:
> On Fri, 04 Jul 2008, Matthew Garrett wrote:
> > hal has bound to input devices for years. It won't run code directly, 
> > since that's a policy decision, but lshal -m should show events come 
> > from input devices.
> 
> Is there an easy way to duplicate what acpid does (i.e. give HAL some config
> file that tells it to run an extrenal script when it gets a certain event)?
> If there is not, it is no wonder people don't want to go away from acpid and
> we have to keep proc_generate_event around...

Right, that's why I'm not encouraging its removal from any existing 
drivers at the moment. I was under the impression that there was an 
acpid that could listen for input devices somewhere, but I'm having 
trouble finding that now. Hm.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
