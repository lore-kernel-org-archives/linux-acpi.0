From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Turn off graphics
Date: Sun, 4 Sep 2011 14:43:01 +0100
Message-ID: <20110904134301.GA6255@srcf.ucam.org>
References: <4E637A01.1000502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59260 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab1IDNnF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Sep 2011 09:43:05 -0400
Content-Disposition: inline
In-Reply-To: <4E637A01.1000502@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaw Xiao <theshawsark@gmail.com>
Cc: linux-acpi@vger.kernel.org

There's no generic ACPI mechanism for this. Some machines with dual GPUs 
have ACPI methods for turning the discrete controller on and off, but in 
general you'd be looking at doing this from the GPU driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
