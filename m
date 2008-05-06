From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 1/2] ACPI PM: Add suspend sequence workaround
Date: Tue, 6 May 2008 22:57:53 +0100
Message-ID: <200805062257.55554.carlos@strangeworlds.co.uk>
References: <200805062342.42789.rjw@sisk.pl> <200805062344.31117.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:53152 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbYEFV7K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 May 2008 17:59:10 -0400
In-Reply-To: <200805062344.31117.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <greg@kroah.com>

On Tuesday 06 May 2008 22:44:30 Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> There are some systems out there that don't work correctly with
> our current suspend/hibernation code ordering.  Provide a workaround
> for these systems allowing them to pass the
> 'acpi_old_suspend_ordering' command line parameter to the kernel that
> will make it use the pre-ACPI 2.0 suspend code ordering.

Can we tack on a set of DMI matches to this somewhere to automatically apply 
this to the systems we know so far that need the old ordering?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
