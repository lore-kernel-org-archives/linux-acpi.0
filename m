From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [2.6.31-rc6] ACPI region conflict regression...
Date: Sun, 16 Aug 2009 11:35:03 +0100
Message-ID: <20090816103503.GA3073@srcf.ucam.org>
References: <6278d2220908160259v38c34c4ck6db2853ae886492@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36176 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbZHPKfD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Aug 2009 06:35:03 -0400
Content-Disposition: inline
In-Reply-To: <6278d2220908160259v38c34c4ck6db2853ae886492@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sun, Aug 16, 2009 at 10:59:38AM +0100, Daniel J Blueman wrote:

> Is there a way to relax this, or does it require adding
> acpi_bus_register_driver(struct acpi_driver) and the needed code this
> late in the game?

acpi_enforce_resources=lax

-- 
Matthew Garrett | mjg59@srcf.ucam.org
