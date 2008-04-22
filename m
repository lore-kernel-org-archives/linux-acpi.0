From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [patch 3/9] acpi: adjust register handling
Date: Tue, 22 Apr 2008 09:01:59 +0100
Message-ID: <480DB797.76E4.0078.0@novell.com>
References: <200804182027.m3IKRPrs013544@imap1.linux-foundation.org>
 <1208862915.14474.31.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vpn.id2.novell.com ([195.33.99.129]:49833 "EHLO
	vpn.id2.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295AbYDVIWF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Apr 2008 04:22:05 -0400
In-Reply-To: <1208862915.14474.31.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: lenb@kernel.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org

>>> Zhao Yakui <yakui.zhao@intel.com> 22.04.08 13:15 >>>
>On Fri, 2008-04-18 at 13:27 -0700, akpm@linux-foundation.org wrote:
>> From: "Jan Beulich" <jbeulich@novell.com>
>> 
>> acpi_hw_low_level_{read,write}() have no need to accept a NULL reg argument
>> anymore (all callers use addresses of or derived from ACPI globals), and it
>> really should always have been considered an error to call these functions in
>> such a way.
>IMO this is inappropriate. On some laptops there are some optional
>register blocks . For example: PM1b_event_block, PM1B_control_block. 
>And the optional register block will be accessed in many functions. (For
>example: sleep flowchart, power_off flowchart).
>If the AE_BAD_PARAMETER is returned by acpi_hw_low_level_read when the
>reg doesn't exist, there will be many regressions.

No, that's not the case: as said in the description, the register structures
are static (hence the addresses of them are never NULL) - an optional,
not implemented register is identified by the address field inside the
register structure being zero (which is still being accounted for, as it
was before the change).

Jan

