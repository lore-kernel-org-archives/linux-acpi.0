From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH resend] dell-wmi: Add support for new Dell WMI based
	HotKey
Date: Mon, 24 Aug 2009 22:36:50 +0100
Message-ID: <20090824213650.GA20695@srcf.ucam.org>
References: <1251149646-13654-1-git-send-email-Rezwanul_Kabir@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38199 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbZHXVg4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2009 17:36:56 -0400
Content-Disposition: inline
In-Reply-To: <1251149646-13654-1-git-send-email-Rezwanul_Kabir@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rezwanul Kabir <Rezwanul_Kabir@dell.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Aug 24, 2009 at 04:34:06PM -0500, Rezwanul Kabir wrote:
> Newer Dell systems support HotKey features differently from legacy systems.
> A new vendor specifc HotKey SMBIOS table (Type 0xB2) is defined. This
> table contains a mapping between scancode and the corresponding predefined
> keyfunction ( i.e. keycode).. Also, a new ACPI-WMI event type (called 
> KeyIDList) with a value of 0x0010 is defined. Any BIOS containing 0xB2 
> table will send hotkey notifications using KeyIDList event.
> 
> 
> Signed-off-by: Rezwanul Kabir <Rezwanul_Kabir@dell.com>

I don't have the hardware to test this right now, but assuming it's been 
tested on old hardware as well as machines with the new interface:

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
