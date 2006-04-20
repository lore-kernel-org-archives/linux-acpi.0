From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Thu, 20 Apr 2006 17:15:46 +0100
Message-ID: <20060420161546.GB30021@srcf.ucam.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:40071 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751032AbWDTQPy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 12:15:54 -0400
Content-Disposition: inline
In-Reply-To: <4447AF4D.7030507@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 07:57:01PM +0400, Alexey Starikovskiy wrote:

> I think you will agree that ACPI buttons are special and will need special 
> handling even in input stream...
> Generic application does not need to know if power, sleep, or lid button is 
> pressed, so you will need to intercept them from input stream... I cannot 
> find any reason to mix these buttons into input, do you?

On many machines, they're /already/ in the input stream. Applications 
that misbehave if they receive unknown keycodes are broken and need 
fixing in any case.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
