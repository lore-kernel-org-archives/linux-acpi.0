From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Preventing ACPI from Damaging Your CPU
Date: Fri, 13 Oct 2006 05:53:39 +0100
Message-ID: <20061013045339.GA534@srcf.ucam.org>
References: <1160663160.13196.273175261@webmail.messagingengine.com> <20061013012430.GA31911@srcf.ucam.org> <1160714475.18692.273233665@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:48078 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750783AbWJMExs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Oct 2006 00:53:48 -0400
Content-Disposition: inline
In-Reply-To: <1160714475.18692.273233665@webmail.messagingengine.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathew Brown <mathewbrown@fastmail.fm>
Cc: linux-acpi@vger.kernel.org

On Thu, Oct 12, 2006 at 09:41:15PM -0700, Mathew Brown wrote:
> Thanks Matthew.  Just out of curiosity, how did you find out about this
> feature (forcing the fan at 80C)?  Also, is this specific to HP or do
> other vendors also support this?  Finally, is 80C safe for the CPU
> (Intel or AMD?)?  I read that Opteron chips could be damaged if their
> temperature reaches 70C.  Thanks for your help.

A certain amount of reverse engineering of HP hardware while I was 
trying to diagnose some fan problems before. The fan control chip that 
HP use is pretty standard, so I think there are docs around somewhere.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
