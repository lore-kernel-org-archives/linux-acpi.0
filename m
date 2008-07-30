From: Mattia Dongili <malattia@linux.it>
Subject: Re: Sony Vaio SZ61MN - no fanspeed control
Date: Thu, 31 Jul 2008 07:36:49 +0900
Message-ID: <20080730223649.GB23998@inferi.kami.home>
References: <4890BC45.2000807@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:43069
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752001AbYG3Wgw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 18:36:52 -0400
Content-Disposition: inline
In-Reply-To: <4890BC45.2000807@uni-koblenz.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Pohl <sebastianp@uni-koblenz.de>
Cc: linux-acpi@vger.kernel.org

On Wed, Jul 30, 2008 at 09:08:53PM +0200, Sebastian Pohl wrote:
> Hi there!
>
> In the process of havin multiple issues with acpi and drivers on my Sony  
> laptop i stepped into another. The internal fan is always running at a  
> fixed speed. If theres much CPU load it also speeds up. But i have no  

the fan is controlled by the bios on most (all those that I know of)
vaios.

> way to alter the speed. It always changes back to some sort of default  
> value. Are there other ways to change the fanspeed than spicctrl with  
> the sonypi module or direct echoing to the fan files made by the acpi  
> stuff?

the bios doesn't expose any fancontrol feature, with sonypi or
sony-laptop you can use spicctrl or, with sony-laptop only,
/sys/devices/platform/sony-laptop/fanspeed to increase the fan speed for
a while but the bios usually brings it back to the required speed.

> This could be dangerous for the hardware as it seems like it doesnt  
> speed up to the highest level so the laptop gets very hot. Also it  
> negatively affects the battery uptime.

does the laptop shuts down because of overheating?
What temperature reading do you get from the acpi thermal zones?

cheers
-- 
mattia
:wq!
