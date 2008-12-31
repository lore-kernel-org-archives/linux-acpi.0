From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH, resend] misc: Add dell-wmi driver for hotkey control
Date: Wed, 31 Dec 2008 00:14:45 +0000
Message-ID: <20081231001445.GA23563@srcf.ucam.org>
References: <20081228153128.GC13424@srcf.ucam.org> <20081230155035.8224ca86.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55262 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbYLaAOt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Dec 2008 19:14:49 -0500
Content-Disposition: inline
In-Reply-To: <20081230155035.8224ca86.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org

On Tue, Dec 30, 2008 at 03:50:35PM -0800, Andrew Morton wrote:

> One wonders whether this driver should really live in drivers/input/?

Mm. There's certainly an argument for that given its current 
functionality, but the Dell WMI interface also exposes a bunch of other 
functionality - we just don't know how to use any of it right now. 
Moving it later might be more confusing.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
