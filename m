From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Fri, 08 Aug 2008 09:41:34 +0100
Message-ID: <489C06BE.2020309@tuffmail.co.uk>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com>	 <48958901.06a0100a.35d6.2df9@mx.google.com>	 <514e099a0808032206n192fc973u24b31def6555dbec@mail.gmail.com>	 <514e099a0808070235qd36628cta191018763875422@mail.gmail.com>	 <1218159124.6671.32.camel@yakui_zhao.sh.intel.com> <514e099a0808072153w2e944037gbfbdf8e9156d7df0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:28263 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbYHHIlj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Aug 2008 04:41:39 -0400
Received: by nf-out-0910.google.com with SMTP id d3so339299nfc.21
        for <linux-acpi@vger.kernel.org>; Fri, 08 Aug 2008 01:41:37 -0700 (PDT)
In-Reply-To: <514e099a0808072153w2e944037gbfbdf8e9156d7df0@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: S K <nospamnoham@gmail.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

S K wrote:
> Hi,
>
> I already did the cpufreq.debug thing and it was using the
> smi_speedstep driver instread of the acpi_speedstep (or whatever is
> the right name).
>
> Alan already told me this is likely an ACPI issue. So, I already sent
> the acpidump in a prev email (Aug 3rd 08). I'm don't have access to my
> home machine right now. Will send it again later if you can't get my
> prev email from the archives.
>   

I could be completely wrong though!

I'd not heard of speedstep_smi before (now I look, it doesn't seem to be
an option in the cpu frequency scaling Kconfig menu?).

I assumed the error messages you had about SMI were just flack.  I
thought  acpi-cpufreq was the only option on recent machines - and that
a quad core  probably counts as recent.  The error messages could be due
to Fedora scripts unconditionally loading several different modules, to
find one that works.

I'm not sure how you can answer Zhao's question if you don't already
know.  I expect Fedora C7 does try loading acpi_cpufreq (as well as
speedstep_smi).  Whether your machine actually supports acpi_cpufreq is
the question we're trying to answer.  (This is where looking at Windows,
or BIOS settings, would help).

Alan
