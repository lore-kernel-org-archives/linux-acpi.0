From: Thomas Renninger <trenn@suse.de>
Subject: Re: Convert PRINT_DEBUG(DB_ERROR/WARNING,...) to ACPI_ERROR/WARNING
Date: Tue, 07 Feb 2006 00:00:42 +0100
Message-ID: <43E7D51A.5000503@suse.de>
References: <971FCB6690CD0E4898387DBF7552B90E0440B436@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:10196 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964855AbWBFXAp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 18:00:45 -0500
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E0440B436@orsmsx403.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: ACPI-ML <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

Moore, Robert wrote:
>> Also added the EXPORT_SYMBOLS(ut_warning/error/exception) function
> decl.
>> in
>> (in a separated patch -> ACPICA, acpi/utilities/utmisc.c).
> 
> Don't these belong somewhere else?
I thought everything in subdirs is ACPICA...

> 
>> Also added errors inside remove/install handler funcs (in a separated
>> patch -> ACPICA,
>> acpi/events/evxface.c).
> 
> So, you are saying that there are insufficient error messages in
> evxface.c, I'll look at it.
> 

Grep in the big one for acpi_remove_notify_handler or
"Error installing notify handler" ...
