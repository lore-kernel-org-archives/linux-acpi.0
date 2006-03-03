From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: Resume problems on Fujitsu-Siemens AMILO M7440G
Date: Fri, 03 Mar 2006 09:36:31 +0800
Message-ID: <1141349791.19013.1.camel@sli10-desk.sh.intel.com>
References: <44076762.404@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:51929 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751231AbWCCBhS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Mar 2006 20:37:18 -0500
In-Reply-To: <44076762.404@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Schierl <schierlm@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Fri, 2006-03-03 at 05:45 +0800, Michael Schierl wrote:
> Hi,
> 
> My new notebook, a Fujitsu-Siemens AMILO M7440G, does not resume
> after 
> suspend (echo mem >/sys/power/state).
> 
> Since my old notebook worked with APM, ACPI stuff is quite new for me;
> I 
>  tried several things but with no success.
> 
> What happens:
> 
> - I boot a minimal kernel (vanilla 2.6.15.2), with init=/bin/bash to 
>   minimize userspace problems (root fs = ext3, mounted read only) 
> - I mount /sys and echo mem >/sys/power/state 
> - my notebook seems to suspend properly, everything powers down,
> power 
>   LED is flashing. (I cannot eject CD now) 
> - when pressing the power button (the notebook cannot be waken up by 
>   pressing keys on the keyboard, but that is the same on Windows, so 
>   most likely by design), the power LED changes to light (without 
>   flashing), and the CDROM spins up. (Now I can eject CD). Screen is 
>   dark and remains so until I power it down hard (by pressing power 
>   button for 5 seconds). 
> - when compiling in network support and netconsole support (and
> enabling 
>   netconsole to maybe get error messages), the 
>   behaviour changes: the CDROM still spins up but the power LED
> remains 
>   flashing. (you can find the .config at 
>   http://home.arcor.de/mschierlm/test/acpi/_config ) No reaction on
> the 
>   net console after suspend. 
> - The notebook does not have any serial ports.
If the video is dark, please try the boot options listed in
documentation/power/video.txt.
Did the keyboard response after resume?

Thanks,
Shaohua

