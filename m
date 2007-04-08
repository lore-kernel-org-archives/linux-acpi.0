From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: x86_pc and ACPI support /sys/devices/.../wakeup
Date: Sun, 8 Apr 2007 10:56:25 -0600
Message-ID: <20070408165625.GE32713@cosmic.amd.com>
References: <200704051248.40745.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:13876 "EHLO
	outbound2-fra-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467AbXDHQ4f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Apr 2007 12:56:35 -0400
In-Reply-To: <200704051248.40745.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On 05/04/07 12:48 -0700, David Brownell wrote:
> Following are three patches for basic driver model wakeup flag support on
> PCs.  I think the first two are nearly mergable.  The third previously broke
> powerpc, so it's likely not yet mergeable ... the issue was arch-specific
> differences in PCI initialization, someone else will need to solve them.
> 
> The patches are:
> 
>  - Define a platform_enable_wakeup() PM hook and use it with PCI.  (This
>    might help OLPC with its non-RTC events...)

Neat!  I'll looking forward to studying it in more detail.  I've also
forwarded this e-mail and the three patches to devel@laptop.org for their
perusual.

Jordan


