From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Ubuntu patch enabling speedstep for sonoma processors
Date: Thu, 24 Jun 2010 18:29:32 -0600
Message-ID: <4C23F86C.5090502@gmail.com>
References: <4C237EAE.3000908@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37409 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab0FYA3f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jun 2010 20:29:35 -0400
In-Reply-To: <4C237EAE.3000908@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>, Linux ACPI <linux-acpi@vger.kernel.org>

On 06/24/2010 09:50 AM, Ozan =C3=87a=C4=9Flayan wrote:
> Hi,
>
> The following patch enables speedstep for sonoma processors:
> http://kernel.ubuntu.com/git?p=3Dubuntu/ubuntu-maverick.git;a=3Dblobd=
iff;f=3Darch/x86/kernel/cpu/cpufreq/speedstep-centrino.c;h=3Dee4e9f8050=
752923f9671f61ffbea662bc9ad12a;hp=3D9b1ff37de46ae6a729f48d2d94ad3054880=
6884d;hb=3D23120eb5ae5a12924565e8af3d946a015e1caaf9;hpb=3D215cc71ef0b26=
b9434404f387681d9bd173d2434
>
> The patch never got accepted by upstream after some discussions:
>
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-06/msg01078.html
>
> """
> This patch has been floating around for years.
> So long, I've forgotten the original reason it wasn't accepted.
> It had something to do with it working for some users, but not others=
,
> and we can't detect the 'not working' case.
>
> speedstep-centrino is also deprecated in favour of acpi-cpufreq for s=
ome time.
> If acpi isn't working on these machines, we should find out why.
>
> Dave Jones
> """
>
> """
> My recollection is that we had no way to work out which voltage table
> was appropriate for a given CPU, so there was a risk of us either ove=
r-
> or under-volting the chip. Doing it via ACPI is safe.
>
> Matthew Garrett
> """
>
> I have bug report from a user which complains that frequency scaling =
is not available
> on its computer. This patch fixes the issue but seen the discussions =
there should be a
> better and more correct way to fix the issue.
>
> What should I do in order to debug and try to fix it?
>
> And also seen that Ubuntu carries this patch for a relatively long ti=
me, did you see
> any negative effect like the aforementioned risk of over/under-voltin=
g the chip?

The acpidump from that system would be a good start, to figure out why=20
acpi-cpufreq isn't working..
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
