From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v6] acpi: Issue _OSC call for native thermal interrupt
 handling
Date: Wed, 23 Mar 2016 13:22:01 -0700
Message-ID: <1458764521.27934.168.camel@linux.intel.com>
References: <1458706064-4147-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <56F2C7B5.4000208@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:7420 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022AbcCWUY6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Mar 2016 16:24:58 -0400
In-Reply-To: <56F2C7B5.4000208@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Knippers <linda.knippers@hpe.com>, rjw@rjwysocki.net
Cc: tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, 2016-03-23 at 12:43 -0400, Linda Knippers wrote:
> I raised a general concern on a previous patch so I found a 1P server
> with Skylake and HWP to try.=C2=A0=C2=A0This doesn't qualify as a tes=
ted-by
> since all I did was apply the patch and boot the server but hey, it
> booted.
Thanks.

>=20
> I do have a question below...
>=20
[...]
> +	if (ACPI_SUCCESS(acpi_run_osc(handle, &osc_context))) {
> > +		acpi_hwp_native_thermal_lvt_set =3D true;
> > +		kfree(osc_context.ret.pointer);
>=20
> There are other boot messages that indicate when something is
> happening
> with _OSC.=C2=A0=C2=A0Should there be one for this?=C2=A0=C2=A0Or is =
there some other
> obvious
> way one can know that this was set?
>=20
I am following model of=C2=A0acpi_bus_osc_support, which issues _OSC fo=
r
global platform scope, where nothing is getting printed. If it is
useful, I don't mind adding a print.

Rafael,
	What do you think?

Thanks,
Srinivas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
