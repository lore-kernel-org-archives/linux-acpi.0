From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/8] device async action mechanism
Date: Thu, 16 Jul 2009 10:14:43 +0800
Message-ID: <1247710483.26272.170.camel@rzhang-dt>
References: <1247643512.26272.74.camel@rzhang-dt>
	 <87ocrm6xeq.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757140AbZGPCOK@vger.kernel.org>
In-Reply-To: <87ocrm6xeq.fsf@basil.nowhere.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, arjan@linux.intel.com, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2009-07-15 at 18:41 +0800, Andi Kleen wrote:
> Zhang Rui <rui.zhang@intel.com> writes:
> >
> > Currently, in order to make sure that it won't bring any side effec=
ts,
> > I only convert the ACPI battery and i8042 to use this framework, wh=
ich reduces
> > 0.5s+ S3 time(suspend time plus resume time)=C3=AF=C2=BB=C2=BF, fro=
m 7.0s to less than 6.5s.
>=20
> 10.5s+ was intended I guess?
>=20
what do you mean?

the kernel device suspend time is reduced from 3.2s to 2.8s after
applying this patch set in my test box.
And I get more optimistic numbers on another laptop, an Eeepc 901,
from about 2s to 1.6s. And the shutdown time is also reduced 0.4s.

thanks,
rui
