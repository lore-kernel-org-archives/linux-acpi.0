From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: brightness control on thinkpad t61p
Date: Wed, 26 Dec 2007 22:23:21 +0000
Message-ID: <20071226222321.GA32297@srcf.ucam.org>
References: <20071223000057.739d5891.akpm@linux-foundation.org> <20071224073406.GA1018@srcf.ucam.org> <20071226141027.6d1a509f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:43612 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbXLZWXf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Dec 2007 17:23:35 -0500
Content-Disposition: inline
In-Reply-To: <20071226141027.6d1a509f.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, Dec 26, 2007 at 02:10:27PM -0800, Andrew Morton wrote:

> Vice versa for me.  The thinkpad_acpi driver in 2.6.23 _does_ work,
> but its interface vanished in 2.6.24-rc5 and the acpi driver does not
> work.

As I said, the interface for the ACPI backlight driver is confusing. 10 
will only work if the firmware supports it - have you tried other 
values?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
