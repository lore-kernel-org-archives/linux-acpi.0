From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: the role of the dstd
Date: Wed, 13 Sep 2006 12:09:29 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4EE1869@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59411 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1750933AbWIMTJr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Sep 2006 15:09:47 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: =?iso-8859-1?Q?Rusl=E1n_Ledesma_Garza?= <ruslanledesmagarza@gmail.com>, linux-acpi@vger.kernel.org

We have a "slack mode" for the interpreter which enables the "MS compat=
ibility" features. For Linux, this mode is enabled by default.

Acpi_serialize is in fact used to serialize all methods, for those syst=
ems that have trouble with multiple threads.=20

We do see systems that apparently do not fail on Windows, but fail on A=
CPICA based systems (fail with multithread issues.) We are still invest=
igating these, perhaps timing related.

Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Sanjoy Mahajan
> Sent: Wednesday, September 13, 2006 12:05 PM
> To: Moore, Robert
> Cc: Rusl=E1n Ledesma Garza; linux-acpi@vger.kernel.org
> Subject: Re: the role of the dstd
>=20
> Interesting; thanks for the correction.  So acpi_serialize isn't
> necessarily the right option to use?
>=20
> -Sanjoy
>=20
> `Never underestimate the evil of which men of power are capable.'
>          --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
