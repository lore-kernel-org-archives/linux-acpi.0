From: ykzhao <yakui.zhao@intel.com>
Subject: Re: BUG: scheduling while atomic in acpi_ps_complete_op
Date: Wed, 26 Aug 2009 22:13:04 +0800
Message-ID: <1251295984.3623.83.camel@localhost.localdomain>
References: <1250873707.2168.38.camel@dhcp231-106.rdu.redhat.com>
	 <4A8EFFB2.4040100@suse.de>
	 <1250886352.2168.83.camel@dhcp231-106.rdu.redhat.com>
	 <4A8F1081.3020803@suse.de>
	 <1251124609.2359.25.camel@dhcp231-106.rdu.redhat.com>
	 <1251248426.3623.47.camel@localhost.localdomain>
	 <1251287895.2270.25.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933022AbZHZONW@vger.kernel.org>
In-Reply-To: <1251287895.2270.25.camel@dhcp231-106.rdu.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2009-08-26 at 19:58 +0800, Eric Paris wrote:
> On Wed, 2009-08-26 at 09:00 +0800, ykzhao wrote:
> > On Mon, 2009-08-24 at 22:36 +0800, Eric Paris wrote:
> > > On Sat, 2009-08-22 at 01:24 +0400, Alexey Starikovskiy wrote:
> > > > Eric Paris =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
> > > It does stop my slew of warnings.  Not sure it completely fixes m=
y
> > > problems though....
> > Will you please add the boot option of initcall_debug and attach th=
e
> > output of dmesg?
> > It will be helpful if you can attach the output of acpidump.
> > Thanks.
Hi
	Will you please confirm whether this issue happens on the 2.6.31-rc6
kernel?
	If there is no such issue, will you please revert the following commit
and see whether the issue still exists?
   >commit 74b5820808215f65b70b05a099d6d3c969b82689
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Wed Jul 29 15:54:25 2009 -0600

    ACPI: bind workqueues to CPU 0 to avoid SMI corruption

      In this commit it will schedule to other kernel thread and switch
to task 0 again.

Thanks.
    Yakui.   =20
>=20
> Here is booting a kernel without the change.  I don't see acpidump
> packaged in fedora.  Do you have a pointer to the source or maybe a
> static binary?  I'll look myself later in the afternoon.
>=20
> -Eric
