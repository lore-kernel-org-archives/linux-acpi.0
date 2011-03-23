From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/4] X86: Revamp reboot behaviour to match Windows more
 closely
Date: Wed, 23 Mar 2011 00:08:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103230003310.10549@x980>
References: <1299877940-6870-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:54043 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab1CWEIt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 00:08:49 -0400
In-reply-to: <1299877940-6870-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

On Fri, 11 Mar 2011, Matthew Garrett wrote:

> Windows reboots by hitting the ACPI reboot vector (if available), trying
> the keyboard controller, hitting the ACPI reboot vector again and then
> giving the keyboard controller one last go. Rework our reboot process a
> little to default to matching this behaviour, although we'll fall through
> to attempting a triple fault if nothing else works.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

Acked-by: Len Brown <len.brown@intel.com>

This looks like "tip" material.

thanks,
Len Brown, Intel Open Source Technology Center
