From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Patch] acpi: introduce "acpi_addr=" parameter for kdump
Date: Tue, 22 Mar 2011 21:36:33 -0700
Message-ID: <m1lj06zc4u.fsf@fess.ebiederm.org>
References: <1299766243-494-1-git-send-email-amwang@redhat.com>
	<20110310082600.b52de7fb.rdunlap@xenotime.net>
	<4D86F3A7.8060706@redhat.com>
	<alpine.LFD.2.02.1103230026170.10549@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1103230026170.10549@x980> (Len Brown's message
	of "Wed, 23 Mar 2011 00:28:21 -0400 (EDT)")
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Cong Wang <amwang@redhat.com>, Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org, Takao Indoh <tindoh@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Len Brown <lenb@kernel.org> writes:

> On Mon, 21 Mar 2011, Cong Wang wrote:
>
>> =E4=BA=8E 2011=E5=B9=B403=E6=9C=8811=E6=97=A5 00:26, Randy Dunlap =E5=
=86=99=E9=81=93:
>> > On Thu, 10 Mar 2011 22:10:43 +0800 Amerigo Wang wrote:
>> > > +	acpi_addr=3D	[ACPI,EFI]
>> > > +			Pass the RSDP address to the kernel, mostly used
>> > > +			on machines running EFI runtime service to boot the
>> > > +			second kernel for kdump.
>> > > +
>> >=20
>> > I think that "acpi_addr" is a bit too generic.  How about
>> > acpi_rsdp or acpi_root instead?
>> >=20
>>=20
>> Yup, I agree "acpi_rsdp" is better.
>
> This should also be [KEXEC], and the code should be #ifdef CONFIG_KEX=
EC
> so that sane people can exclude it from their kernels.

So far sane people don't use EFI on x86 so that is easy enough.

Eric
