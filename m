From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: mpparse_{32,64}.c merge questions
Date: Tue, 11 Mar 2008 20:34:36 +0300
Message-ID: <47D6C2AC.8010907@suse.de>
References: <47CDB9D7.9030107@suse.de> <47CDBFD9.1050703@suse.de> <20080304213552.GD8944@elte.hu> <200803111328.43314.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51401 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752497AbYCKReq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 13:34:46 -0400
In-Reply-To: <200803111328.43314.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andi Kleen <ak@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>

Len Brown wrote:
> I agree with Ingo on the "keep it simple" merge steps..
> 
> I can't resist mentioning, however, what I'd like to see long term.
> 
> I'd like to see mpparse.o depend on CONFIG_MPS=y
> I'd like to be able to build CONFIG_ACPI=y and CONFIG_MPS=n
That was original goal set by Andy Kleen.

Thanks,
Alex.
