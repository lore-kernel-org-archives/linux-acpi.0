From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/6] acpi-cpufreq and powernow-k8 fixes
Date: Mon, 21 Jan 2013 01:04:02 +0100
Message-ID: <20130121000402.GA19343@pd.tnic>
References: <1358677470-17394-1-git-send-email-bp@alien8.de>
 <1838903.lYvY4Nk4I1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1838903.lYvY4Nk4I1@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?utf-8?B?QW5kcsOp?= Przywara <andre@andrep.de>, Leonid Isaev <lisaev@umail.iu.edu>, Tom Gundersen <teg@jklm.no>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 20, 2013 at 03:18:11PM +0100, Rafael J. Wysocki wrote:
> Well, it all looks reasonable to me.
>
> I suppose you'd like it to go into v3.8 plus v3.7-stable, right?

Well, sort of.

Patch 0001 which you've already taken and tagged for 3.7-stable and is
on its way to 3.8 is fine since it fixes a bug.

The rest are, IMHO, more or less annoyances fixes which could easily
wait for 3.9 and maybe be backported if there really is an issue. Also,
they'd see a lot more testing this way. Because in at least 99% of the
cases, acpi-cpufreq and powernow-k8 are modules and the handoff works
there.

This is at least how I see it, you tell me whether it makes sense or
not.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
