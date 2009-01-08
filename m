From: Norbert Preining <preining@logic.at>
Subject: Re: How to help with sony-laptop on Vaio VGN-TT11
Date: Fri, 9 Jan 2009 00:41:27 +0100
Message-ID: <20090108234127.GB19979@gamma.logic.tuwien.ac.at>
References: <496634F2.3080505@iworks.at> <alpine.LFD.2.00.0901081534190.4505@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:38390 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbZAHXlm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jan 2009 18:41:42 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901081534190.4505@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Michael Wallner <mike@iworks.at>, linux-acpi@vger.kernel.org

Hi Len, hi all,

On Do, 08 Jan 2009, Len Brown wrote:
> I've recently got a VGN-z540 and was impressed at how bright it is too:-)
> 
> they hotkeys do not work,
> however, echo into /sys/class/backlight/*/brightness files works,
> do you have those files?

VGN Z11 same problem. hardware keys don't work, but via /sys it does.

Michael: Which kernel you are running? There have been some fixed which
helped my laptop to at least get the /sys files working.

The problems is that the /sys files for the wwan interface etc are NOT
working, they are not doing anything useful AFAI could deduce. 

Len, does it work on yours? Do you have a WWAN interface built in?

Since both the Z11 (mine) and the Z540 (Len's) are very similar AFAIR
(seems to be only naming differences for different markets) maybe we can
fix that ...

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
ABERCRAVE (vb.)
To strongly desire to swing from the pole on the rear footplate of a
bus.
			--- Douglas Adams, The Meaning of Liff
