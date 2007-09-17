From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Notification on method execution
Date: Mon, 17 Sep 2007 02:55:30 +0100
Message-ID: <20070917015529.GA17164@srcf.ucam.org>
References: <20070915204923.GA27604@srcf.ucam.org> <20070916143824.GA4869@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:53460 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbXIQBzh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Sep 2007 21:55:37 -0400
Content-Disposition: inline
In-Reply-To: <20070916143824.GA4869@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

On Sun, Sep 16, 2007 at 11:38:24AM -0300, Henrique de Moraes Holschuh wrote:

> I'm afraid the very old ones might lack the embedded controller support you
> need, especially those without ACPI (but we don't support them anyway).

A quick scan seems to suggest that stuff back to at least the T23 will 
work here, which I think is probably the vast majority of anything 
anyone's still using. I've hacked preliminary support into Ubuntu in 
order to get an idea of what level of bizarrness we could expect, but it 
seems to work pretty well in my initial testing. Once I've got a better 
idea how well this will work, I'll submit some patches.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
