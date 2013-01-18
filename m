From: Borislav Petkov <bp@alien8.de>
Subject: Re: [arch-general] powernow-k8 fails to load with linux 3.7.2
Date: Fri, 18 Jan 2013 18:10:51 +0100
Message-ID: <20130118171051.GC4062@pd.tnic>
References: <1448223.sdUJnNSRz4@vostro.rjw.lan>
 <20130116231728.GA10204@x1.alien8.de>
 <20130116181600.4c48ee3b@bluemoon>
 <20130117094648.GD30700@pd.tnic>
 <20130117194044.7a18a29d@bluemoon>
 <20130118113717.GA6808@pd.tnic>
 <20130118133233.4521ddb6@hydra>
 <E99CBA9F97C3D149AA6B19ED2E277C9B0193997E@BY2PRD0510MB365.namprd05.prod.outlook.com>
 <20130118152633.GA4062@pd.tnic>
 <E99CBA9F97C3D149AA6B19ED2E277C9B019399B6@BY2PRD0510MB365.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:46736 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab3ARRK5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2013 12:10:57 -0500
Content-Disposition: inline
In-Reply-To: <E99CBA9F97C3D149AA6B19ED2E277C9B019399B6@BY2PRD0510MB365.namprd05.prod.outlook.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: =?utf-8?B?QW5kcsOp?= Przywara <andre@andrep.de>, Leonid Isaev <lisaev@umail.iu.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tom Gundersen <teg@jklm.no>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Jan 18, 2013 at 03:32:45PM +0000, Matthew Garrett wrote:
> On Fri, 2013-01-18 at 16:26 +0100, Borislav Petkov wrote:
> > Yep, that should be one way to fix it.
> > 
> > One other fix IMHO would be if udev is looking at CPUID bits, to teach
> > it to check the proper P-States feature bits on Intel and AMD:
> 
> I think it makes more sense to use the existing CPU modaliases than to
> special-case it in udev.

Well, actually, those CPUID bits are there for exactly that reason: to
query them and enable software features. And this is one of the reasons
CPUID is a ring 3 instruction: so that even userspace can use it.

So, in a perfect world, udev should simply run CPUID, check the
respective bits, and, if they're set, load the respective driver. That
is, if it doesn't do it already.

No need for additional code glue in the kernel or anywhere else.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
