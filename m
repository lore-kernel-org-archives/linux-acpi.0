From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [2.6.28] Kernel panic after closing lid on HP 2510p
Date: Thu, 15 Jan 2009 02:59:45 +0000
Message-ID: <20090115025945.GA19472@srcf.ucam.org>
References: <200901121356.46236.elendil@planet.nl> <20090113123056.GA2464@deprecation.cyrius.com> <20090114162603.c632d82e.akpm@linux-foundation.org> <20090115020311.GA18740@srcf.ucam.org> <20090114181542.34614acf.akpm@linux-foundation.org> <20090115022106.GA19069@srcf.ucam.org> <1231988103.20746.149.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51877 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbZAOC7v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jan 2009 21:59:51 -0500
Content-Disposition: inline
In-Reply-To: <1231988103.20746.149.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Martin Michlmayr <tbm@cyrius.com>, "elendil@planet.nl" <elendil@planet.nl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, fengguang.wu@intel.com

On Thu, Jan 15, 2009 at 10:55:03AM +0800, Zhang Rui wrote:

> DIDL is an IGD OpRegion field, as the Supported Display Devices ID Li=
st.
> =EF=BB=BFit's evaluated by the _DOD method when ACPI video driver is =
loaded.
> And according to the spec, "The graphics driver writes to this field
> once during its initialization"
> if DIDL is not empty, a flag is set and the SMI will not be invoked w=
hen
> closing the lid.
> In our tests, this field (DIDL) is set in windows when _DOD is invoke=
d
> while it's not in Linux.
> I can workaround this bug by setting the DIDL manually in AML code.

Oh, huh. Yeah, that sounds plausible. I'll give it a go here tomorrow.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
