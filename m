From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Paravirtualizing bits of acpi access
Date: Sat, 21 Mar 2009 21:26:00 -0700
Message-ID: <49C5BDD8.1050605@goop.org>
References: <49C484B7.20100@goop.org> <200903211810.53990.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:51661 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbZCVE0F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Mar 2009 00:26:05 -0400
In-Reply-To: <200903211810.53990.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>

Rafael J. Wysocki wrote:
> Well, why don't you implement the platform suspend operations for Xen?
> I guess you don't want ACPI _PTS to be executed during suspend as well.
>   

I don't know.  What's _PTS?

I think for the most part we want Linux to do most of the acpi work of 
bringing the machine into an idle state.  Its just that Xen is 
responsible for the very low level cpu context save/restore, because the 
Linux kernel is still running on vcpus rather than the physical cpus.

    J
