From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 57/98] sony-laptop: Add support for extra keyboard events
Date: Sun, 29 Mar 2009 17:02:12 +0100
Message-ID: <20090329160212.GA9129@srcf.ucam.org>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <200903291253.05030.matze@welwarsky.de> <20090329150338.GA8500@srcf.ucam.org> <200903291751.45455.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47402 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbZC2QCR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Mar 2009 12:02:17 -0400
Content-Disposition: inline
In-Reply-To: <200903291751.45455.matze@welwarsky.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Welwarsky <matze@welwarsky.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

On Sun, Mar 29, 2009 at 05:51:45PM +0200, Matthias Welwarsky wrote:
> before the call to acpi_bus_generate_proc_event(). It was called 
> unconditionally, with whatever value ev happened to have at that time, i.e. 
> also unprocessed events < 0x90 or events where the translation failed. Moving 
> the call makes sure that only properly processed events are reported. Without, 
> I was seeing a lot of bogus events reported, e.g. volume-down when the stamina 
> switch was flipped, or when the rf kill switch was operated.

Oh, I see. No, you can't just remove it from there - that'll break 
older-style events. I'd add it there without removing the original, but 
then make the rest of the block conditional on the original event not 
being >= 0x90.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
