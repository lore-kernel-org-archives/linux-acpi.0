From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ACPI notify handler and reentrancy of WMI device.
Date: Mon, 17 Jan 2011 10:05:42 +0800
Message-ID: <1295229942.28388.87.camel@minggr.sh.intel.com>
References: <AANLkTi=hBDt+Ej+hNcxxnw4ZjPZ930kR13DVjtt50zwD@mail.gmail.com>
	 <AANLkTim0auvcUeDSO7QGSVbj0A+g88FSon7-qT6KzBHd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52933 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab1AQCFW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Jan 2011 21:05:22 -0500
In-Reply-To: <AANLkTim0auvcUeDSO7QGSVbj0A+g88FSon7-qT6KzBHd@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>


> From: Corentin Chary <corentin.chary@gmail.com>
> Date: Mon, Jan 17, 2011 at 2:18 AM
> Subject: ACPI notify handler and reentrancy of WMI device.
> To: linux acpi <linux-acpi@vger.kernel.org>
> Cc: platform-driver-x86@vger.kernel.org, Len Brown
> <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>
> 
> 
> Hi,
> I currently trying to fix a bug on the Eeepc 1000H with eeepc-wmi.
> 
> I got an acpi notify handler. The notify is triggered when I call WMBC().
> In this notify handler, I must re-call WMBC (with some other arguments, it won't
> notify again this time).
> 
> If I do that, I'll get:
> [  176.920391] ACPI Error (dswload-0802): [_T_0] Namespace lookup
> failure, AE_ALREADY_EXISTS
> [  176.920416] ACPI Exception: AE_ALREADY_EXISTS, During name
> lookup/catalog (20100428/psloop-231)
> [  176.920439] ACPI Error (psparse-0537): Method parse/execution
> failed [\AMW0.WMBC] (Node f7023b88), AE_ALREADY_EXISTS
> [  176.920469] ACPI: Marking method WMBC as Serialized because of
> AE_ALREADY_EXISTS error

Hi, 

Could you attach the acpidump output?

Thanks,
Lin Ming

> 
> Then it'll work.
> 
> What's the best way to avoid that ?
> - Is there some way to tell acpica that this method should be serialized ?
> - Is there some way to finish the execution of the first WMBC call in
> the notify handler ?
> - Should I use a work queue, and do what I have to do later (when the
> previous call is finished) ?
> - anything else ?
> 
> Thanks,
> 
> --
> Corentin Chary
> http://xf.iksaif.net
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


