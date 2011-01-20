From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ACPI notify handler and reentrancy of WMI device.
Date: Thu, 20 Jan 2011 17:55:11 +0800
Message-ID: <1295517311.11852.7.camel@minggr.sh.intel.com>
References: <AANLkTi=hBDt+Ej+hNcxxnw4ZjPZ930kR13DVjtt50zwD@mail.gmail.com>
	 <AANLkTim0auvcUeDSO7QGSVbj0A+g88FSon7-qT6KzBHd@mail.gmail.com>
	 <1295229942.28388.87.camel@minggr.sh.intel.com>
	 <AANLkTinfP+-L2T4oggiTpMwE74V6kxgcrStHumYGiH23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <AANLkTinfP+-L2T4oggiTpMwE74V6kxgcrStHumYGiH23@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2011-01-17 at 14:51 +0800, Corentin Chary wrote:
> >> I got an acpi notify handler. The notify is triggered when I call WMBC().
> >> In this notify handler, I must re-call WMBC (with some other arguments, it won't
> >> notify again this time).
> >>
> >> If I do that, I'll get:
> >> [  176.920391] ACPI Error (dswload-0802): [_T_0] Namespace lookup
> >> failure, AE_ALREADY_EXISTS
> >> [  176.920416] ACPI Exception: AE_ALREADY_EXISTS, During name
> >> lookup/catalog (20100428/psloop-231)
> >> [  176.920439] ACPI Error (psparse-0537): Method parse/execution
> >> failed [\AMW0.WMBC] (Node f7023b88), AE_ALREADY_EXISTS
> >> [  176.920469] ACPI: Marking method WMBC as Serialized because of
> >> AE_ALREADY_EXISTS error
> >
> > Could you attach the acpidump output?
> 
> Here it is, and here is the patch I did (I used the workqueue solution
> in this one):
> 
> http://git.iksaif.net/?p=acpi4asus.git;a=blobdiff;f=drivers/platform/x86/eeepc-wmi.c;h=725239860bad8d97dabf8b3db4086d6df4b7820b;hp=0d8217d1478028071859ba1a503ba226b3cb33a0;hb=1eac4d6a6fb632314a464e7d52e1dcb1e4780931;hpb=5c5d1a036bb7d38153c6d2102767ef51e5d94ce3
> 
> (check eeepc_rfkill_notify, it's triggered when the wlan rfkill is
> blocked: WMBC is called to disable the wlan card, it send a
> notification, the handler is called, the handler want to check the
> wlan card status, it calls WMBC again).
> Thanks;
> 

Sorry for late reply.

WMBC is not an ACPI spec defined method (which always start with "_",
_ADR, _DSW etc), the driver should only call ACPI spec defined method.
What does this method do?

And, I don't see any call to WMBC in eeepc-wmi.c or above patch.

Lin Ming
