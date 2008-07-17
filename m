From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 10/11] thinkpad_acpi: fingers off backlight if video.ko
 is serving this functionality
Date: Thu, 17 Jul 2008 11:10:51 +0200
Message-ID: <487F0C9B.4010502@linux.intel.com>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <20080716124703.GA376@srcf.ucam.org> <20080716133839.GB3329@khazad-dum.debian.net> <200807161727.57026.trenn@suse.de> <20080716152938.GA8676@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:20928 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752981AbYGQJKw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 05:10:52 -0400
In-Reply-To: <20080716152938.GA8676@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, jwoithe@physics.adelaide.edu.au, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

Matthew Garrett wrote:
> On Wed, Jul 16, 2008 at 05:27:55PM +0200, Thomas Renninger wrote:
>> On Wednesday 16 July 2008 15:38:39 Henrique de Moraes Holschuh wrote:
>>> On Wed, 16 Jul 2008, Matthew Garrett wrote:
>>>> On Wed, Jul 16, 2008 at 09:40:44AM -0300, Henrique de Moraes Holschuh 
>> wrote:
>>>>> One question: is there a good reason to actually have the hotkey
>>>>> handling for IGD mode directly in thinkpad-acpi?  We don't do it for
>>>>> Vista BIOS, video.ko doesn't do it either (anymore)... and I would make
>>>>> it configurable for IBM firmware if I could.
>>>> No. There's no reason to have IGD handling in thinkpad-acpi at all.
>> I haven't seen the video driver on a T61 with Intel card doing proper 
>> backlight switching on the correct device yet.
> 
> The patch is queued and will be in 2.6.27. It's fine.

I admit I have lost track of the state of these patches. If there's an 
agreed subset of patches that should go in post .27 via ACPI please 
resend them for review.

Thanks,

-Andi
