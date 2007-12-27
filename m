From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: brightness control on thinkpad t61p
Date: Thu, 27 Dec 2007 10:33:58 -0200
Message-ID: <20071227123358.GB25535@khazad-dum.debian.net>
References: <20071223000057.739d5891.akpm@linux-foundation.org> <20071224073406.GA1018@srcf.ucam.org> <20071226141027.6d1a509f.akpm@linux-foundation.org> <20071226222321.GA32297@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:52734 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461AbXL0MeE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Dec 2007 07:34:04 -0500
Content-Disposition: inline
In-Reply-To: <20071226222321.GA32297@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 26 Dec 2007, Matthew Garrett wrote:
> On Wed, Dec 26, 2007 at 02:10:27PM -0800, Andrew Morton wrote:
> 
> > Vice versa for me.  The thinkpad_acpi driver in 2.6.23 _does_ work,
> > but its interface vanished in 2.6.24-rc5 and the acpi driver does not
> > work.
> 
> As I said, the interface for the ACPI backlight driver is confusing. 10 
> will only work if the firmware supports it - have you tried other 
> values?

Not on a thinkpad.  The AML code is not that stupid, it rounds down to the
nearest supported value.   It takes a brightness percentage (0 to 100), maps
it through a table to get the visual brightness -> hardware brightness curve
right (it is non-linear), then does what thinkpad-acpi does to set backlight
brightness.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
