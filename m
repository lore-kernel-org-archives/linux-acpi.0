From: Borislav Petkov <bp@alien8.de>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Mon, 21 Jan 2013 11:54:55 +0100
Message-ID: <20130121105455.GA4823@pd.tnic>
References: <1448223.sdUJnNSRz4@vostro.rjw.lan>
 <20130116231728.GA10204@x1.alien8.de>
 <20130116181600.4c48ee3b@bluemoon>
 <20130117094648.GD30700@pd.tnic>
 <20130117194044.7a18a29d@bluemoon>
 <20130118113717.GA6808@pd.tnic>
 <20130118133233.4521ddb6@hydra>
 <E99CBA9F97C3D149AA6B19ED2E277C9B0193997E@BY2PRD0510MB365.namprd05.prod.outlook.com>
 <20130119120814.GA4026@pd.tnic>
 <20130120231432.67351ee6@bluemoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130120231432.67351ee6@bluemoon>
Sender: cpufreq-owner@vger.kernel.org
To: Leonid Isaev <lisaev@umail.iu.edu>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, =?utf-8?B?QW5kcsOp?= Przywara <andre@andrep.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tom Gundersen <teg@jklm.no>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 20, 2013 at 11:14:32PM -0600, Leonid Isaev wrote:
> Matthew and Borislav, thanks a lot for the patch and explanation!
>
> I applied the above patch on top of linux 3.7.3 -- it does generate
> the aliases and fixes the autoprobing issue, at least on my AMD
> machine. Should we expect it in 3.7.4 or 3.8? Otherwise, I'll forward
> it to archlinux devel ML to be possibly included in current -stable
> kernel. Also, Borislav, this patch is not in your patch series, is it?

Yeah, it's not.

Matthew, care to write a proper commit message with your SOB and
Leonid's Tested-by pls?

Then Rafael could take it for 3.8 and tag it for 3.7-stable, methinks.

Leonid, thanks for testing.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
