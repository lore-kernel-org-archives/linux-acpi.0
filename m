From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Run-time PM idea (was: Re: [linux-pm] [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 14:44:51 +0100
Message-ID: <20090608134451.GB15482@srcf.ucam.org>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org> <20090608131159.GA15100@srcf.ucam.org> <20090608132235.GC13214@elte.hu> <200906081539.20459.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49510 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbZFHNo6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jun 2009 09:44:58 -0400
Content-Disposition: inline
In-Reply-To: <200906081539.20459.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Ingo Molnar <mingo@elte.hu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Mon, Jun 08, 2009 at 03:39:19PM +0200, Oliver Neukum wrote:

> For example do you really need every key pressed while the screen saver
> is running or is it enough for the keyboard to be able to generate a wakeup
> event?

Depends whether you have a media player running or not...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
