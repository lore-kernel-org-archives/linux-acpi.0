From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH] disable _BQC/_BCQ if it returns invalid values
Date: Thu, 09 Jul 2009 03:27:23 +0200
Message-ID: <4A55477B.9080909@marcansoft.com>
References: <4A54FE96.2030407@marcansoft.com> <1247101051.15520.194.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from marcansoft.com ([80.68.93.119]:51449 "EHLO smtp.marcansoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756545AbZGIB11 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jul 2009 21:27:27 -0400
In-Reply-To: <1247101051.15520.194.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Zhang Rui wrote:
> _BQC returns a value larger than 100?
> is this true on your laptop?

Yes, it returns random garbage. It is completely broken. There's an if()
in the ASL that disables the entire method (including no valid return
value) when a certain EC SRAM register is 0. The backlight code also
constantly clears this register. I suppose the EC should theoretically
set it at some point, but it doesn't (at least not reliably). In any
case, _BQC isn't needed here since the hardware doesn't change the
screen brightness autonomously, and disabling the method as soon as it
misbehaves works just fine.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc

