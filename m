From: Andi Kleen <ak@linux.intel.com>
Subject: Re: ACPI OSI disaster on latest HP laptops - critical temperature
 shutdown
Date: Sat, 26 Jul 2008 05:42:27 -0700
Message-ID: <488B1BB3.7010602@linux.intel.com>
References: <200807241727.41715.trenn@suse.de> <alpine.LFD.1.10.0807241952270.6098@localhost.localdomain> <200807251319.12786.trenn@suse.de> <200807251726.14366.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:1602 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751818AbYGZMmZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Jul 2008 08:42:25 -0400
In-Reply-To: <200807251726.14366.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christian Kornacker <ckornacker@suse.de>


> If vendors use _OSI(Windows) to work around Windows bugs, we get broken
> automatically on those systems unless we put in some DMI-based hacks.

The general goal of ACPICA is to be bug-to-bug compatible with Windows.
So it might be needed for ACPICA to just emulate the respective bugs.

That said for this case I don't think that's needed, Linux just has to
detect the workarounds (which it already does I think)

-Andi

