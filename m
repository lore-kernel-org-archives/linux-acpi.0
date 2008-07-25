From: Andi Kleen <ak@linux.intel.com>
Subject: Re: ACPI OSI disaster on latest HP laptops - critical temperature
 shutdown
Date: Fri, 25 Jul 2008 03:44:35 -0700
Message-ID: <4889AE93.4090601@linux.intel.com>
References: <200807241727.41715.trenn@suse.de> <alpine.LFD.1.10.0807241952270.6098@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:14473 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753674AbYGYKod (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Jul 2008 06:44:33 -0400
In-Reply-To: <alpine.LFD.1.10.0807241952270.6098@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, Arjan van de Ven <arjan@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christian Kornacker <ckornacker@suse.de>

Len Brown wrote:
> Thomas,
> 
> re: OSI(Windows...)

Thomas,

I discussed this with Len here in Ottawa. First I fully agree with his 
reasoning for the current behaviour.

The main problem with OSI(Linux) is that it would be a quickly moving 
target so checking for it wouldn't really help the BIOSes.

Still there might be special cases where BIOSes will still check (e.g.
if they intend to work with specific distribution releases which might 
have specific bugs). Or to check for specific Linux features.

One way to do the later would be to define new OSI flags for specific
features. Haven't got a good proposal for that currently, but it's a 
possibility.

The other thing that could be done is to define OSI flags specific for
special distribution releases so BIOSes could potentially check for bugs
in SLED10 or RHWS5 or something like this, which are hopefully stable
in that behaviour doesn't move as quickly. The way to do that wouldn't
be to change the kernel though, but just specify them on the command 
line using acpi_osi=...

-Andi

