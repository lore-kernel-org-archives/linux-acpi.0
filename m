From: Thomas Renninger <trenn@suse.de>
Subject: Re: cpufreq doesn't seem to work in Intel Q9300
Date: Sat, 9 Aug 2008 21:30:14 +0200
Message-ID: <200808092130.14719.trenn@suse.de>
References: <514e099a0808030300u140a0ae7m92a2e7294f39f7b7@mail.gmail.com> <aff5deaf0808081123s1fbe6a5cn7847e9cb053c1f5a@mail.gmail.com> <200808092059.47863.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44171 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbYHITNz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Aug 2008 15:13:55 -0400
In-Reply-To: <200808092059.47863.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: S K <nospamnoham@gmail.com>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Zhao Yakui <yakui.zhao@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

just that in case you try out kernels...

On Saturday 09 August 2008 08:59:47 pm Thomas Renninger wrote:
> On Friday 08 August 2008 08:23:25 pm S K wrote:

> Mark Langsdorf reported some acpi breakage in .27-rc1, this could als=
o be
> the reason.
---------
> I got a regression when updated from 2.6.27-rc1 ro
> 2.6.27-rc2. =A0The noticeable symptom is the powernow-k8
> driver stopped working because the call to=20
> acpi_processor_register_performance() is returning
> -EINVAL.
----------

So it's rc2 not rc1, but AFAIK your report should be older than rc2.

There also was a similar report from Laurence Darby <ldarby@tuffmail.co=
m>.
He still posted on the old cpufreq list.
Subject: Core 2 Duo E8400 stepping 6 not recognised

A BIOS update helped.
You may be able to google this out and compare his CPU_FREQ_DEBUG logs.

      Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
