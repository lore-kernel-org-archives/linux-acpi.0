From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] ACPICA: Remove unnecessary "\n" from an ACPI_INFO boot
 message
Date: Wed, 30 Mar 2016 22:11:29 -0300
Message-ID: <56FC7941.2080202@redhat.com>
References: <74bc15316c48bb33c0954d94c0595720ee0955bd.1459187689.git.bristot@redhat.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E455538@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43376 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbcCaBLd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Mar 2016 21:11:33 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E455538@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 03/29/2016 04:09 PM, Moore, Robert wrote:
> Actually, I did in fact put that there to break up the output after the tables are loaded. Is this a problem?

Well, I do not believe that there is a real problem on it.

On the other hand, it does not seem to be common to have blank lines in
the kernel log, and as there is no info about from where the black line
comes from, it does not even seems to be connected to the previous
message. So although my patch is about "cosmetics", IMHO it is worth as
pattern or best practices. Feel free to reject if it is not the case, np
:-).

-- Daniel
