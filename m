From: Mattia Dongili <malattia@linux.it>
Subject: Re: sony-laptop support for Vaio VGN-C2S
Date: Mon, 2 Mar 2009 21:39:48 +0900
Message-ID: <20090302123948.GB24234@kamineko.org>
References: <1235996539.4378.4.camel@dexmobile>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:49281
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbZCBMjv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2009 07:39:51 -0500
Content-Disposition: inline
In-Reply-To: <1235996539.4378.4.camel@dexmobile>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luis Nabais <luis.nabais@caixamagica.pt>
Cc: linux-acpi@vger.kernel.org

On Mon, Mar 02, 2009 at 12:22:19PM +0000, Luis Nabais wrote:
> I have a vaio VGN-C2S and some of the fn-keys (brightness and the
> monitor/tv-out key) don't work and since I don't know how to go and hack
> the module to get the keys working I thought you could help me.

what kernel version are you using?

> I attached the DSTD dump in this message.

can you also send the output from 
  dmidecode -t system
and the kernel log after unloading and reloading the sony-laptop module
with
  modprobe sony-laptop debug=1
also press some of non-working Fn keys and see if they show up in the
kernel log.

thanks
-- 
mattia
:wq!
