From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Should asus-wmi provide a way to switch displays, and why
	video_output class is unused
Date: Mon, 21 Feb 2011 20:24:02 +0000
Message-ID: <20110221202402.GA22622@srcf.ucam.org>
References: <AANLkTimf3SL+BpzjVK=F9y4_dGnDp6ghmMKq5k=4hs0x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38986 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab1BUUYM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Feb 2011 15:24:12 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimf3SL+BpzjVK=F9y4_dGnDp6ghmMKq5k=4hs0x@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Luming Yu <luming.yu@intel.com>

Thought I'd replied to this already, but: Unless it's impossible for X 
and the kernel to handle enabling a display without this, don't bother. 
There's no reason for us to care about the combinations of outputs the
BIOS wants to support.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
