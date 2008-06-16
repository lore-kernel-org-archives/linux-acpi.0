From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: kernel panic when plugging in USB device and closing lid
Date: Mon, 16 Jun 2008 13:36:23 +0100
Message-ID: <20080616123623.GA21609@srcf.ucam.org>
References: <20080616123238.GA2852@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58264 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbYFPMg2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jun 2008 08:36:28 -0400
Content-Disposition: inline
In-Reply-To: <20080616123238.GA2852@deprecation.cyrius.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-kernel@vger.kernel.org, keithp@keithp.com, linux-acpi@vger.kernel.org

On Mon, Jun 16, 2008 at 02:32:38PM +0200, Martin Michlmayr wrote:

> I briefly talked to Matthew Garrett on IRC who said this "looks like
> state corruption".  He asked me to set /proc/acpi/video/blah/DOS to 7
> and see whether I could still reproduce the problem.  After setting
> this value, I no longer see the kernel panic.  Matthew: "Right.  The
> lid-close SMM seems to blow things up some of the time."

If DOS is set to 1, the BIOS seems to do something that makes the kernel 
massively unhappy. Disabling the automatic display switch control avoids 
this, which makes me think it's a BIOS bug of some description.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
