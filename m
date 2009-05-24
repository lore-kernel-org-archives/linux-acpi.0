From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 09/19] eeepc-laptop: support for super hybrid engine (SHE)
Date: Sun, 24 May 2009 10:28:38 +0100
Message-ID: <9b2b86520905240228y5cf7111dsa6d5d34e03360bd9@mail.gmail.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
	 <1242453736-20763-1-git-send-email-lenb@kernel.org>
	 <158ca1d75dd0d6223f3b1dd741d30777da62ab80.1242453625.git.len.brown@intel.com>
Reply-To: alan-jenkins@tuffmail.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:33266 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbZEXJ2i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 May 2009 05:28:38 -0400
Received: by bwz22 with SMTP id 22so2471649bwz.37
        for <linux-acpi@vger.kernel.org>; Sun, 24 May 2009 02:28:38 -0700 (PDT)
In-Reply-To: <158ca1d75dd0d6223f3b1dd741d30777da62ab80.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grigori Goronzy <greg@chown.ath.cx>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>, alan-jenkins@tuffmail.co.uk

On 5/16/09, Len Brown <lenb@kernel.org> wrote:
> From: Grigori Goronzy <greg@chown.ath.cx>
>
> The older eeepc-acpi driver allowed to control the SHE performance
> preset through a ACPI function for just this purpose. SHE underclocks
> and undervolts the FSB and undervolts the CPU (at preset 2,
> "powersave"), or slightly overclocks the CPU (at preset 0,
> "performance"). Preset 1 is the default setting with default clocks and
> voltage.
>
> The new eeepc-laptop driver doesn't support it anymore.
> The attached patch adds support for it to eeepc-laptop. It's very
> straight-forward and almost trivial.
>
> Signed-off-by: Grigori Goronzy <greg@chown.ath.cx>
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---

Hi, out of curiosity I tried this on my EeePC 701.  I upgraded the
BIOS to the latest version available a few months ago.

I find that the file is present and can successfully be read from.
The file returns the value "513".  If I write "1" to it, nothing
happens.  If I write "0" to it, the speakers start hissing and the
file then returns the value "512".  Writing "1" again gets it back to
normal.  There is no apparent effect on performance.

This is stupid, because we _do_ appear to check the BIOS supported
features bitmask, but that's Asus firmware for you.  Can you please
add an extra test, so this file only allows  reads or writes if the
current value is 0 or 1?  If you're quick you might slip it into -rc8
:-).

I think this is the only attribute which needs this treatment.  It
looks like the SHE feature may have been attempted for the 701 model,
but not completed on time.

Thanks!
Alan
