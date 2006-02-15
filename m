From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: fix vendor resource length computation
Date: Wed, 15 Feb 2006 18:49:48 +0100
Message-ID: <43F369BC.9050604@suse.de>
References: <971FCB6690CD0E4898387DBF7552B90E045AACFA@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E045AACFA@orsmsx403.amr.corp.intel.com>
Sender: linux-ia64-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andreas Schwab <schwab@suse.de>, "Luck, Tony" <tony.luck@intel.com>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org, Andrew Morton <akpm@osdl.org>, efocht@hpce.nec.com
List-Id: linux-acpi@vger.kernel.org

Moore, Robert wrote:
> I think the original code may have been attempting to subtract off the
> size of the descriptor header to obtain the length of the vendor data
> bytes. However, something like a global replace may have broken it.
> 
Thanks, this one fixes the mem corruption.
Unaligned access messages still remain...


   Thomas
