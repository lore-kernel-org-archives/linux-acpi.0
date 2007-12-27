From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: brightness control on thinkpad t61p
Date: Thu, 27 Dec 2007 10:31:59 -0200
Message-ID: <20071227123159.GA25535@khazad-dum.debian.net>
References: <20071223000057.739d5891.akpm@linux-foundation.org> <20071224073406.GA1018@srcf.ucam.org> <20071226141027.6d1a509f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:56154 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751361AbXL0McG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Dec 2007 07:32:06 -0500
Content-Disposition: inline
In-Reply-To: <20071226141027.6d1a509f.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 26 Dec 2007, Andrew Morton wrote:
> Vice versa for me.  The thinkpad_acpi driver in 2.6.23 _does_ work,
> but its interface vanished in 2.6.24-rc5 and the acpi driver does not
> work.

As I said, give thinkpad-acpi the brightness_enable=1 parameter, and it will
export its backlight interface, regardless of the presence of a generic ACPI
backlight interface in the AML...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
