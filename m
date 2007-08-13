From: Norbert Preining <preining@logic.at>
Subject: Re: regression from 2.6.23-rc2 to -rc3 BAT missing
Date: Mon, 13 Aug 2007 12:10:09 +0200
Message-ID: <20070813101009.GB4881@gamma.logic.tuwien.ac.at>
References: <20070813094354.GA4881@gamma.logic.tuwien.ac.at> <46C02D52.40002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:53684 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765487AbXHMKKL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Aug 2007 06:10:11 -0400
Content-Disposition: inline
In-Reply-To: <46C02D52.40002@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 13 Aug 2007, Alexey Starikovskiy wrote:
> Do you know if you have SBS or CM battery? 
> What driver do you use: sbs.ko or battery.ko?

I am quite sure that it is a CM battery, not a SBS:

CONFIG_ACPI_BATTERY=y

did normal work, and CONFIG_ACPI_SBS=m but module not loaded. Same
setting as always.

I also loaded sbs.ko without any change.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SCREMBY (n.)
The dehydrated felt-tip pen attached by a string to the 'Don't Forget'
board in the kitchen which has never worked in living memory but which
no one can be bothered to throw away.
			--- Douglas Adams, The Meaning of Liff
