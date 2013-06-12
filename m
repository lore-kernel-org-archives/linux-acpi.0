From: Larry Baker <baker@usgs.gov>
Subject: Re: Wishlist: Disable C6 in intel_idle for Model 44 processors
Date: Wed, 12 Jun 2013 11:11:21 -0700
Message-ID: <1BD2BF18-8FAA-4633-8B6D-7CA2D6AE67AC@usgs.gov>
References: <38D8523B-C50E-4D81-A9E2-526292B19AF3@usgs.gov> <20130612134002.GA15317@srcf.ucam.org>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [137.227.28.13] ([137.227.28.13]:13206 "EHLO smtp7.doi.gov"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754884Ab3FLSL6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jun 2013 14:11:58 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so7055883pac.1        for
 <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2013 11:11:25 -0700 (PDT)
In-Reply-To: <20130612134002.GA15317@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Rob E Russell <robr@us.ibm.com>

On 12 Jun 2013, at 6:40 AM, Matthew Garrett wrote:

> On Tue, Jun 11, 2013 at 02:30:30PM -0700, Larry Baker wrote:
>> I have an IBM System x3650 M3 with an Intel Xeon L5630 processor.  M=
y IBM support team alerted me to an issue with C6 states for those proc=
essors when running Linux and the intel_idle kernel module is used.  Th=
e IBM solutions page, http://www-947.ibm.com/support/entry/portal/docdi=
splay?lndocid=3Dmigr-5091901, recommends disabling intel_idle.  I propo=
se intel_idle disable C6 for the affected processors.
>=20
> As you note:
>=20
>>> Workaround:=20
>>> It is possible for the BIOS to contain a workaround for this erratu=
m.

Not my comment -- this comes from the Intel processor errata.  It is no=
t really very clear from this exactly what the BIOS is supposed to do. =
 The IBM BIOS, for example, disables all C states.  However, intel_idle=
 ignores the BIOS settings.

I did some Google'ing and found HP and Dell documents describing how to=
 configure Linux to reduce latency, which, of course, requires that C s=
tates be disabled.

http://h20000.www2.hp.com/bc/docs/support/SupportManual/c01804533/c0180=
4533.pdf
http://en.community.dell.com/techcenter/extras/m/white_papers/20227764/=
download.aspx

The Dell document explains that the intel_idle driver overrides what th=
e BIOS says and does its own thing.  It says the acpi_idle driver gets =
the ACPI information from the BIOS and does what it says to do:

> And, to reiterate=E2=80=94there are a number of kernel parameters and=
 BIOS settings that deal with C-states, but most of these will be ignor=
ed if intel_idle is in use. Disabling intel_idle with kernel parameter =
=E2=80=95intel_idle.max_cstate=3D0 will result in more intuitive contro=
l of C-states, and there should not be any disadvantage to disabling it=
 on systems that provide correct C-state information to the operating s=
ystem via ACPI.

Maybe disabling intel_idle is the best solution?  I don't know.  But, i=
f that is so, why does Linux have it at all?  I suspect it is because i=
ntel_idle can use C states that are Intel processor-specific, while acp=
i_idle probably sticks to ACPI "standard" C states.

> Are you actually seeing this specific problem?

On my systems, not that I know of.  The processor errata only says this=
 may happen.  I only have a few, and I suppose I have been lucky.  I am=
 sure that Intel would have caught this prior to shipping the processor=
 if it was a solid failure.  My IBM support contact has told me that it=
 has caused grief at his accounts.

> If so, you should=20
> probably request a firmware update from IBM. If that's not a=20
> possibility, and if it is necessary to disable package C6 in this=20
> situation, it'd be nice to determine what the BIOS workaround actuall=
y=20
> does and limit the quirk to that case.

The processor errata is operating system agnostic.  I suspect the BIOS =
workaround they envision would be a feature in the BIOS to limit the ch=
oice of C states to be used.  The IBM BIOS has such a setting, and the =
default value is to completely disable C states.  However, intel_idle i=
gnores the BIOS setting.

I think the intel_idle code came from Intel engineers.  I assume they h=
ave good reason to prefer it to acpi_idle.  I hope they read this list =
and will decide if my proposals have merit.

Thanks.

> --=20
> Matthew Garrett | mjg59@srcf.ucam.org

Larry Baker
US Geological Survey
650-329-5608
baker@usgs.gov

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
