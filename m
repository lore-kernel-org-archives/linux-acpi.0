From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] ACPI: make acpi_idle Nehalem-aware
Date: Thu, 22 Jul 2010 09:47:50 +0200
Message-ID: <20100722074750.GA22520@one.firstfloor.org>
References: <20100427124703.GA16706@jgarrett.org> <alpine.LFD.2.00.1004301218280.2489@sony> <20100430174447.GA14889@srcf.ucam.org> <d7f2dd35a4361e5156079278543769a0@localhost> <alpine.LFD.2.00.1005250125590.20648@localhost.localdomain> <CE761E84DADF2947A4AF22FB8D97A4731E0366B5@shsmsx501.ccr.corp.intel.com> <20100525124325.GC7876@srcf.ucam.org> <alpine.LFD.2.00.1005251114420.4114@localhost.localdomain> <20100525185507.GA15997@srcf.ucam.org> <alpine.LFD.2.00.1007211729550.409@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:45021 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758448Ab0GVHrz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jul 2010 03:47:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1007211729550.409@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Yu, Luming" <luming.yu@intel.com>, Philip Langdale <philipl@overt.org>, Jeff Garrett <jeff@jgarrett.org>, Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "venki@google.com" <venki@google.com>

> If a device in the system really does want to prevent use
> of a deep C-state, its Linux driver should register its
> constraints via pm_qos_add_request().

I reviewed the patch and it looks good to me.

I would suggest to have a command line option for this too,
in case someone wants to run an older kernel on a new system not
known by your patch yet.

-Andi

