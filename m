From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/4] ACPI: Add acpi_pr_<level>() interfaces
Date: Wed, 25 Jul 2012 11:11:49 -0700
Message-ID: <1343239909.7045.2.camel@joe2Laptop>
References: <1342803256-17514-1-git-send-email-toshi.kani@hp.com>
	 <1342803256-17514-2-git-send-email-toshi.kani@hp.com>
	 <1343200017.30161.3.camel@joe2Laptop>
	 <1343238829.3010.394.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:58122 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752333Ab2GYSLu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 14:11:50 -0400
In-Reply-To: <1343238829.3010.394.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, liuj97@gmail.com, srivatsa.bhat@linux.vnet.ibm.com, prarit@redhat.com, imammedo@redhat.com, vijaymohan.pandarathil@hp.com

On Wed, 2012-07-25 at 11:53 -0600, Toshi Kani wrote:
> On Wed, 2012-07-25 at 00:06 -0700, Joe Perches wrote:
> > On Fri, 2012-07-20 at 10:54 -0600, Toshi Kani wrote:
> > > This patch introduces acpi_pr_<level>(), where <level> is a message
> > > level such as err/warn/info, to support improved logging messages
> > > for ACPI, esp. in hotplug operations.  acpi_pr_<level>() appends
> > > "ACPI" prefix and ACPI object path to the messages.  This improves
> > > diagnostics in hotplug operations since it identifies an object that
> > > caused an issue in a log file.
> 
> Hi Joe,
> 
> Thanks for reviewing!
> 
> > trivia:
> 
> Did you mean to say something more on this?  Just checking...

No.  I just intended to note that the comments that followed
weren't particularly important nor should it really stop the
patch from being applied if you didn't want to update it.

cheers, Joe

