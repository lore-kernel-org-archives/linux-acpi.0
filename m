From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH 0/7] sony-laptop for acpi-test
Date: Mon, 3 Nov 2008 12:17:21 +0100
Message-ID: <20081103111721.GA31688@gamma.logic.tuwien.ac.at>
References: <1225705280-12775-1-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:35487 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891AbYKCLRX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 06:17:23 -0500
Content-Disposition: inline
In-Reply-To: <1225705280-12775-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

Hi Mattia,

On Mo, 03 Nov 2008, Mattia Dongili wrote:
> here is a first submission with some of the backlog I accumulated in
> these months.

I tried your patches on top of 2.6.28-rc3 and the tests showed:
- backlight is working via sys interface and xbacklight
- hardkeys are still not working
- wifipower, wwanpower, bluetoothpower sys files do not work

All on Sony Vaio VGN-Z11

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
AITH (n.)
The single bristle that sticks out sideways on a cheap paintbrush.
			--- Douglas Adams, The Meaning of Liff
