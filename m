From: Yu Luming <luming.yu@intel.com>
Subject: Re: power down regression: 2.6.18-rc5 against 2.6.18-rc4 on i386,  82371AB/EB/MB PIIX4
Date: Tue, 5 Sep 2006 15:09:55 +0800
Message-ID: <200609051509.56013.luming.yu@intel.com>
References: <44F854C2.50607@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52328 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965186AbWIEHDz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Sep 2006 03:03:55 -0400
In-Reply-To: <44F854C2.50607@ntlworld.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ael <law_ence.dev@ntlworld.com>
Cc: linux-acpi@vger.kernel.org

On Friday 01 September 2006 23:41, ael wrote:
> On 2.6.18-rc4 and all earlier versions, power-down is called when the
>  system is shutdown: the last message on screen is Power down & shutdown.
>
>  On 2.6.18-rc5, there is no call to power down: the last message is
>  "System Halted" and power remains on.

Sounds like a regression.  Please file a bug on bugzilla.kernel.org
if it is ACPI related, please put it in ACPI category.

Thanks,
Luming
