From: Thomas Renninger <trenn@suse.de>
Subject: Re: powernow-k8: No compatible ACPI _PSS objects found. (Asrock N68-S)
Date: Fri, 14 May 2010 23:08:01 +0200
Message-ID: <201005142308.01960.trenn@suse.de>
References: <hr8dum$ivs$1@dough.gmane.org> <4BD7C0FF.5030302@erley.org> <hr8h5q$qt7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:39362 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759443Ab0ENVHq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 May 2010 17:07:46 -0400
In-Reply-To: <hr8h5q$qt7$1@dough.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Manuel =?iso-8859-1?q?Arg=FCelles?= <manuel.arguelles@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 28 April 2010 07:30:32 am Manuel Arg=FCelles wrote:
> Pat Erley wrote:
> > I recently did something similar: http://pat.erley.org/Other/P4EIST=
SSDT
> >
> > It wasn't 'too hard', but it was by no means easy... the _PSS value=
s were
> > kinda voodoo for me to come up with, and I'm not sure that I have t=
hem
> > correct, just that they work.
> >
> > Pat
>
> Thanks a lot!! I took a look at my ssdt and it doesn't even looks com=
plete:
>
> DefinitionBlock ("SSDT.aml", "SSDT", 1, "A M I ", "POWERNOW", 0x00000=
001)
> {
That sounds promising.
Did you update your BIOS to the latest version?
If not, do that first.
Are you sure you went through all BIOS configs?
Eventually you upgraded the CPUs?

Best open a bug on https://bugzilla.kernel.org and assign it to the cpu=
freq
component and CC me.
Upload DSDT, SSDTs or best just acpidump which includes all.

    Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
