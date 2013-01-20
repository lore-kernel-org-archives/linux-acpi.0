From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] acpi-cpufreq and powernow-k8 fixes
Date: Sun, 20 Jan 2013 15:18:11 +0100
Message-ID: <1838903.lYvY4Nk4I1@vostro.rjw.lan>
References: <1358677470-17394-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1358677470-17394-1-git-send-email-bp@alien8.de>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: =?ISO-8859-1?Q?Andr=E9?= Przywara <andre@andrep.de>, Leonid Isaev <lisaev@umail.iu.edu>, Tom Gundersen <teg@jklm.no>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Sunday, January 20, 2013 11:24:24 AM Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Hi all,
> 
> here are a couple of patches fixing acpi-cpufreq and powernow-k8 loading
> sequence and handoff.
> 
> Patch 0001 should be in Rafael's tree already but I'm adding it here for
> the sake of completeness. Basically, we want to address all possible
> cases of powernow-k8 and acpi-cpufreq:
> 
> (M: module, Y: built-in)
> 
> powernow-k8		acpi-cpufreq
> M			M		- powernow-k8 requests acpi-cpufreq
> M			Y		- powernow-k8 sees already loaded acpi-cpufreq
> Y			M		- impossible after patch 0001
> Y			Y		- patches 2,3 fix that
> 
> Anyway, please take a look and let me know.

Well, it all looks reasonable to me.

I suppose you'd like it to go into v3.8 plus v3.7-stable, right?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
