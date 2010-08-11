From: Andi Kleen <andi@firstfloor.org>
Subject: Re: acpi_os_read_memory() from interrupt context
Date: Wed, 11 Aug 2010 11:25:25 +0200
Message-ID: <87y6cd7b7e.fsf@basil.nowhere.org>
References: <201008041119.23633.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:58799 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757546Ab0HKJZd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Aug 2010 05:25:33 -0400
In-Reply-To: <201008041119.23633.bjorn.helgaas@hp.com> (Bjorn Helgaas's
	message of "Wed, 4 Aug 2010 11:19:23 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, ying.huang@intel.com

Bjorn Helgaas <bjorn.helgaas@hp.com> writes:
> require some redesign in the CA.
>
> Any suggestions?

pre-map. Ying developed a pre map infrastructure for this for the ERST
code. You could probably reuse that.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
