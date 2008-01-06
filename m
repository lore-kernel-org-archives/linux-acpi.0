From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 0/5] WMI
Date: Sun, 6 Jan 2008 01:39:53 +0000
Message-ID: <200801060139.53746.carlos@strangeworlds.co.uk>
References: <20071227153803.4974.97907.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:43222 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbYAFBj6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 20:39:58 -0500
In-Reply-To: <20071227153803.4974.97907.stgit@pacifica>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>

On Thursday 27 December 2007 15:38:04 Carlos Corbacho wrote:
> Patch #1: (WMI - driver and in kernel interface)
>
> Added per GUID event handling callbacks, as per Matthew's suggestion.
>
> Len:
> For review, and to go upstream.
>
> (Bar the EC stuff, this code has also been inflic^^^^tested by acer_acpi
> users with my 0.10 releases, so I'm confident on Acer hardware at least
> that it won't break horribly).
>
> Patch #2: (acer-wmi)
>
> Add device detection for bluetooth and maximum brightness (removes more
> hard coded EC quirks). Also simplified some of the code.
>
> Len:
> For review, and to go upstream.

Len,

Could you please bump up reviewing patches #1 and #2 on your to-do list?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
