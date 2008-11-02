From: Matthew Garrett <mjg@redhat.com>
Subject: Re: eeepc-laptop rfkill, stupid question #4 and 5
Date: Sun, 2 Nov 2008 09:21:04 +0000
Message-ID: <20081102092104.GC10983@srcf.ucam.org>
References: <490B3BB5.8060801@tuffmail.co.uk> <20081031171126.GA17313@srcf.ucam.org> <20081102034620.GA29606@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37246 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbYKBJVK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Nov 2008 04:21:10 -0500
Content-Disposition: inline
In-Reply-To: <20081102034620.GA29606@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

On Sun, Nov 02, 2008 at 01:46:20AM -0200, Henrique de Moraes Holschuh wrote:

> When you don't use rfkill_set_default().  Which, if you are a platform
> driver, and your platform can store state across power off, you should use.

Ah, missed that. Yes, I'll fix that up.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
