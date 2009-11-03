From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [mjg@redhat.com: [PATCH] From: Rezwanul Kabir
	<Rezwanul_Kabir@dell.com>]
Date: Tue, 3 Nov 2009 14:36:37 +0000
Message-ID: <20091103143637.GA7673@srcf.ucam.org>
References: <20091102174748.GA21342@srcf.ucam.org> <20091103034212.GF31712@vmware.com> <20091102174748.GA21342@srcf.ucam.org> <20091103040525.GY25713@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44130 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbZKCOgi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Nov 2009 09:36:38 -0500
Content-Disposition: inline
In-Reply-To: <20091103040525.GY25713@hexapodia.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-acpi@vger.kernel.org

On Mon, Nov 02, 2009 at 08:05:25PM -0800, Andy Isaacson wrote:

> The keyboard.c complaints are from when I hit Fn-F8 (display switch).  I
> can trigger the same complaint with Fn-Left (display brightness auto),
> with code 240.

Hm. 241 is KEY_VIDEO_NEXT - I thought I'd changed that to be 
KEY_SWITCHVIDEOMODE? 240 is KEY_UNKNOWN. I don't think we've currently 
got an appropriate key to map the ALS button to.

> I don't know what event causes the "event 0x11" complaint.  It seems to
> be purely cosmetic and not directly tied to user interaction?

On my test system, that's the "battery with lightning flash" key. I have 
no idea what it's meant to do, or how we're meant to interpret that 
event.

> Fn-F8, Display Toggle, gives code 241 on the WMI event8 *and* code 227
> on /dev/input/event4 "Video Bus".  That seems ... wrong.

Yup. Unfortunately on my system, it only gets delivered via WMI and not 
via ACPI, so doing the same thing as for the brightness keys doesn't 
look like it'll work.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
