From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: patch [0/2]: acpi: add generic removable drive bay support
Date: Fri, 8 Sep 2006 20:59:22 +0100
Message-ID: <20060908195922.GB17220@srcf.ucam.org>
References: <20060907161305.67804d14.kristen.c.accardi@intel.com> <1157679256.3474.48.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:16819 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751149AbWIHUEA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Sep 2006 16:04:00 -0400
Content-Disposition: inline
In-Reply-To: <1157679256.3474.48.camel@nigel.suspend2.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com

On Fri, Sep 08, 2006 at 11:34:16AM +1000, Nigel Cunningham wrote:

> Allow me to anticipate a question I'm sure will come: will this play
> well with (say) suspending while docked and resuming undocked?

Most hardware seems to send a bay event on resume.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
