From: "=?ISO-8859-1?Q?Rusl=E1n_Ledesma_Garza?="
	<ruslanledesmagarza@gmail.com>
Subject: Re: the role of the dstd
Date: Wed, 13 Sep 2006 20:45:30 -0500
Message-ID: <9d90148c0609131845v1ea55b6ag8f3e088a8c5efc62@mail.gmail.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4EE1869@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:13991 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751257AbWINBpe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Sep 2006 21:45:34 -0400
Received: by py-out-1112.google.com with SMTP id n25so3381873pyg
        for <linux-acpi@vger.kernel.org>; Wed, 13 Sep 2006 18:45:34 -0700 (PDT)
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4EE1869@orsmsx415.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, linux-acpi@vger.kernel.org

I've tested this boot option but seems to have no effect on my dell
inspiron 1150 bios version A07. Someone told me to file a bug on
bugzilla, so I expect to do it soon.

On 9/13/06, Moore, Robert <robert.moore@intel.com> wrote:
> We have a "slack mode" for the interpreter which enables the "MS comp=
atibility" features. For Linux, this mode is enabled by default.
>
> Acpi_serialize is in fact used to serialize all methods, for those sy=
stems that have trouble with multiple threads.
>
> We do see systems that apparently do not fail on Windows, but fail on=
 ACPICA based systems (fail with multithread issues.) We are still inve=
stigating these, perhaps timing related.
>
> Bob
>
>
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Sanjoy Mahajan
> > Sent: Wednesday, September 13, 2006 12:05 PM
> > To: Moore, Robert
> > Cc: Rusl=E1n Ledesma Garza; linux-acpi@vger.kernel.org
> > Subject: Re: the role of the dstd
> >
> > Interesting; thanks for the correction.  So acpi_serialize isn't
> > necessarily the right option to use?
> >
> > -Sanjoy
> >
> > `Never underestimate the evil of which men of power are capable.'
> >          --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
