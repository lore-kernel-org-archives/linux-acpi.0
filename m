From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] acpi-cpufreq and powernow-k8 fixes
Date: Mon, 21 Jan 2013 01:13:18 +0100
Message-ID: <7556596.NKy4LTm5hO@vostro.rjw.lan>
References: <1358677470-17394-1-git-send-email-bp@alien8.de> <1838903.lYvY4Nk4I1@vostro.rjw.lan> <20130121000402.GA19343@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130121000402.GA19343@pd.tnic>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: =?ISO-8859-1?Q?Andr=E9?= Przywara <andre@andrep.de>, Leonid Isaev <lisaev@umail.iu.edu>, Tom Gundersen <teg@jklm.no>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Monday, January 21, 2013 01:04:02 AM Borislav Petkov wrote:
> On Sun, Jan 20, 2013 at 03:18:11PM +0100, Rafael J. Wysocki wrote:
> > Well, it all looks reasonable to me.
> >
> > I suppose you'd like it to go into v3.8 plus v3.7-stable, right?
> 
> Well, sort of.
> 
> Patch 0001 which you've already taken and tagged for 3.7-stable and is
> on its way to 3.8 is fine since it fixes a bug.
> 
> The rest are, IMHO, more or less annoyances fixes which could easily
> wait for 3.9 and maybe be backported if there really is an issue. Also,
> they'd see a lot more testing this way. Because in at least 99% of the
> cases, acpi-cpufreq and powernow-k8 are modules and the handoff works
> there.
> 
> This is at least how I see it, you tell me whether it makes sense or
> not.

Yes, it does.

I will take [2-6/6] for v3.9, then, if there are no objections.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
