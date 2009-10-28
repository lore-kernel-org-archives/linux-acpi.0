From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/3] Add a generic API for _OSC
Date: Wed, 28 Oct 2009 16:47:50 +0800
Message-ID: <20091028084750.GA9914@sli10-desk.sh.intel.com>
References: <20091027063637.GA22237@sli10-desk.sh.intel.com> <4AE7174D.8090007@gmail.com> <20091028021930.GA31320@sli10-desk.sh.intel.com> <4AE7FA84.1020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62201 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932727AbZJ1Irr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Oct 2009 04:47:47 -0400
Content-Disposition: inline
In-Reply-To: <4AE7FA84.1020203@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Wed, Oct 28, 2009 at 04:02:12PM +0800, Alexey Starikovskiy wrote:
> Shaohua Li =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, Oct 27, 2009 at 11:52:45PM +0800, Alexey Starikovskiy wrote=
:
> >  =20
> >> Hi Shaohua,
> >>
> >> Could you also make it take a spec string as argument, not a prepa=
red
> >> byte buffer?
> >>    =20
> > Hi,
> > did you mean take the uuid string as an argument of the API? We can
> > add a function to convert a uuid string to binary, but I didn't see
> > any benefit to take the string as argument.
> >
> > Thanks,
> > Shaohua
> >  =20
> Hi,
> Well, right now you are programming in machine codes. If you make
> mistake, no one will notice, even yourself.
> Programming languages were invented to make programs look more readab=
le
> by humans, so that they can see mistakes more easily.
> For the same reason ACPI specification declares UUIDs as strings, whi=
le
> having them in AML as byte arrays.
> Function to convert UUID to byte array already exists, you just need =
to
> use it...
frankly even you use UUID string, it's easy to make mistakes. The strin=
g
is too long. BTW, which function can convert UUID to byte array?

Thanks,
Shaohua
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
