From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 06/12] ACPI, x86: remove ACPI dependency on some
	IO-APIC routines
Date: Fri, 10 Jul 2009 08:51:42 +0200
Message-ID: <20090710065142.GH22218@elte.hu>
References: <8e4a93858bce74ed3080dd607aa471023f1a2737.1247025117.git.len.brown@intel.com> <bf8ea7cda3ad3f287f1c9164d366a94eae07a4a5.1247025117.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:45082 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbZGJGwD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Jul 2009 02:52:03 -0400
Content-Disposition: inline
In-Reply-To: <bf8ea7cda3ad3f287f1c9164d366a94eae07a4a5.1247025117.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, sfi-devel@simplefirmware.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Feng Tang <feng.tang@intel.com>, Len Brown <len.brown@intel.com>


* Len Brown <lenb@kernel.org> wrote:

> From: Feng Tang <feng.tang@intel.com>
> 
> Both ACPI and SFI x86 systems will use these io_apic routines:
> 
> uniq_ioapic_id(u8 id);

While touching this code please also fix the misnomer:

 s/uniq_ioapic_id/unique_ioapic_id

Thanks,

	Ingo
