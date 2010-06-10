From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 1/2] suspend: Move NVS save/restore code to
	generic suspend functionality
Date: Thu, 10 Jun 2010 15:09:11 +0100
Message-ID: <20100610140911.GA11193@srcf.ucam.org>
References: <1275416390.3778.7.camel@maxim-laptop> <201006012331.59747.rjw@sisk.pl> <1275429125.5573.7.camel@maxim-laptop> <201006020040.22429.rjw@sisk.pl> <1275432410.6733.4.camel@maxim-laptop> <20100610135816.GG4514@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48031 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068Ab0FJOJX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2010 10:09:23 -0400
Content-Disposition: inline
In-Reply-To: <20100610135816.GG4514@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>

On Thu, Jun 10, 2010 at 03:58:16PM +0200, Pavel Machek wrote:

> Well... should we only do it in 'platform' hibernation mode? There are
> machines that predate windows/acpi and still should hibernate.

If they predate acpi then they won't declare any NVS regions.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
