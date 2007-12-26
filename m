From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: brightness control on thinkpad t61p
Date: Wed, 26 Dec 2007 14:10:27 -0800
Message-ID: <20071226141027.6d1a509f.akpm@linux-foundation.org>
References: <20071223000057.739d5891.akpm@linux-foundation.org>
	<20071224073406.GA1018@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57502 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751590AbXLZWLR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Dec 2007 17:11:17 -0500
In-Reply-To: <20071224073406.GA1018@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, 24 Dec 2007 07:34:06 +0000 Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Sun, Dec 23, 2007 at 12:00:57AM -0800, Andrew Morton wrote:
> 
> > and /sys/class/backlight/thinkpad_screen/brightness is no longer present, so
> > my `brightness' script no longer works.  That, my friends, is a regression.
> 
> The thinkpad_acpi brightness interface simply doesn't work correctly on 
> recent Thinkpads. The ACPI interface does, but the currently exported ui 
> to it approximates some sort of horrific loss. I'll try to fix that in 
> the next week or so.

Vice versa for me.  The thinkpad_acpi driver in 2.6.23 _does_ work,
but its interface vanished in 2.6.24-rc5 and the acpi driver does not
work.
