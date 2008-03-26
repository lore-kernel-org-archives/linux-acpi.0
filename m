From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend and hibernation
 callbacks (rev. 4)
Date: Thu, 27 Mar 2008 02:27:12 +0300
Message-ID: <47EADBD0.6040400@suse.de>
References: <200803262353.30566.rjw@sisk.pl> <200803270003.51570.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:49940 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755072AbYCZX10 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 19:27:26 -0400
In-Reply-To: <200803270003.51570.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Oliver Neukum <oliver@neukum.org>

Rafael J. Wysocki wrote:
> This is the 4th revision of the patch.
> + * struct pm_noirq_ops - device PM callbacks executed with interrupts disabled
> + *
> + * The following callbacks included in 'struct pm_noirq_ops' are executed with
> + * the nonboot CPUs switched off and with interrupts disabled on the only
> + * functional CPU.  They also are executed with the PM core list of devices
> + * locked, so they must NOT unregister any devices.
> + *
> + * @suspend_noirq: Complete the operations of ->suspend() by carrying out any
> + *	actions required for suspending the device that need interrupts to be
> + *	disabled
IMHO, no need to add _noirq in both struct and struct members.
pm_noirq->suspend_noirq does not look good...

