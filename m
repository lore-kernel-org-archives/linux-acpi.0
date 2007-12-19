From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 2/4] acer-wmi: Add driver for newer Acer laptops
Date: Wed, 19 Dec 2007 01:58:10 +0000
Message-ID: <200712190158.11206.carlos@strangeworlds.co.uk>
References: <20071218235137.12838.75397.stgit@localhost> <20071218235148.12838.25048.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:50533 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbXLSB7t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Dec 2007 20:59:49 -0500
In-Reply-To: <20071218235148.12838.25048.stgit@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tuesday 18 December 2007 23:51:49 Carlos Corbacho wrote:
> This is a driver for newer Acer (and Wistron) laptops. It adds wireless
> radio and bluetooth control, and on some laptops, exposes the mail LED and
> LCD backlight.

Matthew,

>From a distribution (and I suppose support) perspective, what would be a 
sensible default for wireless and bluetooth? (I suppose the wireless bit 
probably also applies to tc1100-wmi).

At the moment, the current behaviour is to just leave these devices alone 
(although they can be overridden from the command line).

Would it be better to default to switching the wireless and bluetooth on 
instead, and leave a command line override for those who would rather they 
default to off?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
