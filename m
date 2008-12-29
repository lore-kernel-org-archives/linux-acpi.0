From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: "I/O resource 0000:00:1f.3 [0x1c00-0x1c1f] conflicts with ACPI region SMBI"
Date: Mon, 29 Dec 2008 14:45:28 +0000
Message-ID: <20081229144528.GA32335@srcf.ucam.org>
References: <1230560872.2328.4.camel@rhapsody> <20081229143508.GD31266@srcf.ucam.org> <1230561737.2328.7.camel@rhapsody>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35697 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbYL2Opa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Dec 2008 09:45:30 -0500
Content-Disposition: inline
In-Reply-To: <1230561737.2328.7.camel@rhapsody>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: The Holy ettlz <theholyettlz@googlemail.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Dec 29, 2008 at 02:42:17PM +0000, The Holy ettlz wrote:

> Well, i2c-i801 is loaded:
> 
> i915                   67080  2 
> drm                   201328  3 i915
> i2c_i801               17820  0 
> i2c_core               29216  2 drm,i2c_i801
> 
> Should I be worried?

As long as nothing is actually using it, you'll be fine.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
