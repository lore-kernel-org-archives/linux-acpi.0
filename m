From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sun, 22 Mar 2009 22:46:52 +0000
Message-ID: <20090322224652.GA13814@srcf.ucam.org>
References: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090320011837.GA23183@gamma.logic.tuwien.ac.at> <200903211222.36642.matze@welwarsky.de> <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60900 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756009AbZCVWq6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Mar 2009 18:46:58 -0400
Content-Disposition: inline
In-Reply-To: <20090322220655.GA13887@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Sun, Mar 22, 2009 at 11:06:55PM +0100, Norbert Preining wrote:

> BUT:
> - suddenly the sony-laptop module is convinced that the *hardware*
>   rfkill switch is always turned on, always. Not even reloading an older
>   sony-laptop helped. Rebooting neither. Shutting down and rebooting
>   with an older sony-laptop as default made wifi show up again.
>   I am not sure if cold booting into the latest version of your patch
>   will work, haven't tried till now, sorry, will do tomorrow.

Hmm. Don't /think/ I did anything that should affect that, but it's 
possible. If it's reproducable, can you try commenting out the 
sony_call_snc_handle calls in sony_nc_function_setup and see if they 
change the behaviour? You'll probably need to reboot in between.

> - S1 and S2 do adjustment of the brightness, while Fn-F5 and Fn-F6 do
>   not do anything, but this is probably only configuration stuff.

Ok, sounds like the mapping needs to be changed. Can you let me know 
which ACPI events are generated for each key?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
