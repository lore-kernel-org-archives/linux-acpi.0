From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Intel-gfx] [RFC PATCH 0/2] i915 brightness control
Date: Thu, 3 Jun 2010 15:19:41 +0100
Message-ID: <20100603141941.GB768@srcf.ucam.org>
References: <1275516702-27090-1-git-send-email-kamal@canonical.com> <AANLkTiktSDWqHg_A8V5_jQsCf1w4k5x9Q7ZOCjAIZTEH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44601 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab0FCOTr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jun 2010 10:19:47 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTiktSDWqHg_A8V5_jQsCf1w4k5x9Q7ZOCjAIZTEH@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: Kamal Mostafa <kamal@canonical.com>, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org

On Thu, Jun 03, 2010 at 12:20:39AM +0100, Pedro Ribeiro wrote:

> Are you sure this is a good idea to enable it by default just because
> of a problem with one manufacturer (Dell)?

It should (a-ha ha) be entirely safe on systems using the IGD opregion 
spec.

> My Lenovo laptop has fine brightness control with a GM45 and this may break it.
> Might be safer only to enable it for laptops with known problems.

You have a complete list of all laptops with problems in this area? The 
ongoing situation with Windows 7 compatibility breaking machines that 
previously worked suggests that there's something going on which we 
don't understand or implement.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
