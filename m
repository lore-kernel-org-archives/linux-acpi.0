From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] dell-wmi Switch support and Tablet switch definition
Date: Fri, 19 Jun 2009 21:34:36 +0100
Message-ID: <20090619203436.GA29122@srcf.ucam.org>
References: <1245410112-13659-1-git-send-email-rafi@seas.upenn.edu> <20090619140228.GA21354@srcf.ucam.org> <4A3BE6F0.7090107@seas.upenn.edu> <20090619194009.GA28382@srcf.ucam.org> <4A3BF5BF.5030102@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51202 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZFSUef (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 16:34:35 -0400
Content-Disposition: inline
In-Reply-To: <4A3BF5BF.5030102@seas.upenn.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-acpi@vger.kernel.org

On Fri, Jun 19, 2009 at 04:31:59PM -0400, Rafi Rubin wrote:

> The signal is not a toggle.  Its an explicit "going to tablet" and "coming from tablet".  And the
> initial value is "non-tablet" mode, which is what must be assumed without this support.

No, it's not - it has state. That's a feature of switches.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
