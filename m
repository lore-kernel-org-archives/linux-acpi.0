From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] dell-wmi Switch support and Tablet switch definition
Date: Fri, 19 Jun 2009 20:40:09 +0100
Message-ID: <20090619194009.GA28382@srcf.ucam.org>
References: <1245410112-13659-1-git-send-email-rafi@seas.upenn.edu> <20090619140228.GA21354@srcf.ucam.org> <4A3BE6F0.7090107@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54762 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZFSTkL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 15:40:11 -0400
Content-Disposition: inline
In-Reply-To: <4A3BE6F0.7090107@seas.upenn.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-acpi@vger.kernel.org

On Fri, Jun 19, 2009 at 03:28:48PM -0400, Rafi Rubin wrote:

> I agree polling the tablet state would be a good thing.  But that does not mean we should not
> support the signals until we are ready to support polling.
> 
> If you are suggesting that we should not use an EV_SW because we will eventually poll the hardware
> instead of keeping the state in software, then I have no problem with sending keys or other events.

No, my point is that there's little benefit in providing EV_SW if the 
initial value is going to be wrong. Software simply can't depend on it. 
The code's absolutely fine, but there's a risk that it'll break 
otherwise working desktops until we know how to set the initial value.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
