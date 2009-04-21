From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] Add support for more dell-wmi hotkeys
Date: Tue, 21 Apr 2009 19:31:00 +0100
Message-ID: <20090421183100.GA8120@srcf.ucam.org>
References: <49ECBAE2.2080308@dell.com> <49EE09D9.2060209@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58642 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbZDUSbI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Apr 2009 14:31:08 -0400
Content-Disposition: inline
In-Reply-To: <49EE09D9.2060209@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 21, 2009 at 01:00:57PM -0500, Mario Limonciello wrote:
> Hi:
> 
> I've got another patch to stack on top of yesterday's patch for Eject. 
> These are more scancode/keycode combinations that will be supported via
> WMI.  Many of them are commented out with an explanation of what their
> true functionality is.

Hmm. I'll take a look over these - I was under the impression that Dell 
volume control was already of the software controlled type? The comments 
about the ones that will send events via both is a bit disconcerting, 
but I'll check how we're handling these keys at the moment.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
