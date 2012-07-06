From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] Suspend,cpuidle:resume_hang fix with cpuidle
Date: Fri, 06 Jul 2012 10:21:23 -0700
Message-ID: <4FF71E93.9000104@linux.vnet.ibm.com>
References: <4FEC20D2.2070501@linux.vnet.ibm.com> <4FF6566B.8020409@linux.vnet.ibm.com> <4FF696D4.4040905@linux.vnet.ibm.com> <201207061923.29748.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:53608 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab2GFRWW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Jul 2012 13:22:22 -0400
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <dave@linux.vnet.ibm.com>;
	Fri, 6 Jul 2012 11:22:20 -0600
In-Reply-To: <201207061923.29748.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: preeti <preeti@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

On 07/06/2012 10:23 AM, Rafael J. Wysocki wrote:
> OK, this looks good to me.  Queuing up in the linux-next branch of the
> linux-pm.git tree.  If no problems with it are reported, I'll move it to the
> pm-cpuidle branch in a couple of days.

I've got this running on the problem hardware.  It seems to be OK, at
least initially, so feel free to add my Tested-by.

