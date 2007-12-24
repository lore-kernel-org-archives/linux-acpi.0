From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: brightness control on thinkpad t61p
Date: Mon, 24 Dec 2007 07:34:06 +0000
Message-ID: <20071224073406.GA1018@srcf.ucam.org>
References: <20071223000057.739d5891.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:32778 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbXLXHeV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Dec 2007 02:34:21 -0500
Content-Disposition: inline
In-Reply-To: <20071223000057.739d5891.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sun, Dec 23, 2007 at 12:00:57AM -0800, Andrew Morton wrote:

> and /sys/class/backlight/thinkpad_screen/brightness is no longer present, so
> my `brightness' script no longer works.  That, my friends, is a regression.

The thinkpad_acpi brightness interface simply doesn't work correctly on 
recent Thinkpads. The ACPI interface does, but the currently exported ui 
to it approximates some sort of horrific loss. I'll try to fix that in 
the next week or so.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
