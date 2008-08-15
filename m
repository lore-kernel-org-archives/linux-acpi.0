From: Jean Delvare <khali@linux-fr.org>
Subject: Re: kernel BUG at arch/x86/mm/pat.c:233 in 2.6.27-rc3-git2
Date: Fri, 15 Aug 2008 11:33:50 +0200
Message-ID: <20080815113350.538d0ba8@hyperion.delvare>
References: <20080814161852.2dce7c21@hyperion.delvare>
	<9D39833986E69849A2A8E74C1078B6B3D7A7CD@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:36441 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbYHOJeF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 05:34:05 -0400
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B3D7A7CD@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-mm@kvack.org, linux-acpi@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, lenb@kernel.org

On Thu, 14 Aug 2008 12:59:45 -0700, Moore, Robert wrote:
> Please open a bugzilla and attach the acpidump for the machine.

Done:
http://bugzilla.kernel.org/show_bug.cgi?id=11346

I've rebuilt the kernel with CONFIG_FRAME_POINTER=y as requested by
Andi. I've also attached the kernel config and the output of dmesg for
the last working kernel. If anything else is needed, just ask.

-- 
Jean Delvare
