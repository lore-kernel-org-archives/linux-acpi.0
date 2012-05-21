From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI ALS Status ?
Date: Mon, 21 May 2012 09:03:46 +0800
Message-ID: <1337562226.1503.12.camel@rui.sh.intel.com>
References: <CAHR064iRm37Wf4QrYEOvsxT0=wZZbY1XQiZfmrJdqyTj1h8sPA@mail.gmail.com>
	 <CAJvTdKnW9VESyiF7Rden698EvRgT=805hyKXtXhFpKkTxLv64w@mail.gmail.com>
	 <CAHR064h74hCe6chXskyT=C+PpQbJ9z2+RYHERoFoYzw9QgzsBA@mail.gmail.com>
	 <CAHR064h4bed0koP--TcJkogMcF_fMYm0dXV74q_jSbuDd98qSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51655 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848Ab2EUBC2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 May 2012 21:02:28 -0400
In-Reply-To: <CAHR064h4bed0koP--TcJkogMcF_fMYm0dXV74q_jSbuDd98qSQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Jonathan Cameron <jic23@cam.ac.uk>, Amit Kucheria <amit.kucheria@verdurent.com>, Jean Delvare <khali@linux-fr.org>

On =E6=97=A5, 2012-05-20 at 15:09 +0200, Corentin Chary wrote:
> On Mon, Mar 5, 2012 at 10:12 AM, Corentin Chary
> <corentin.chary@gmail.com> wrote:
> > On Sun, Nov 6, 2011 at 11:16 PM, Len Brown <lenb@kernel.org> wrote:
> >>> I was looking at the DSDT of a new samsung laptop (I can send you=
 the
> >>> output of acpidump if interested), and it export a standard ACPI =
ALS
> >>> device. So, it's actually great to see vendor using that, but it =
seems
> >>> that the series adding support for that and sent back in 2009 is =
not
> >>> available in the kernel. I'd really like to use my the ALS, what'=
s the
> >>> current status of the driver ? Still blocked because we don't hav=
e a
> >>> generic sysfs class ? If yes, can't we just use a non-standard
> >>> interface ? It would still be better than no driver at all.
> >>
> >> Yes, I think ACPI ALS support has been waiting for hardware to jus=
tify
> >> its existence.
> >>
> >> When it first entered the spec, we were excited to see it was pres=
ent
> >> in some high-end laptops, but IIR on closer examination the AML tu=
rned
> >> out to be dummy code.
> >>
> >> If you can verify that your Samsung really does implement ACPI ALS=
,
> >> then that is all we need to stumble forward.
> >>
> >> thanks,
> >> -Len Brown, Intel Open Source Technology Center
> >
> > Hello,
> >
> > As stated in my previous mails, the implementation on this laptop i=
s
> > perfectly functional,  and since Windows 7 seems to be able to use
> > ACPI ALS nativelly [1] I suspect new (high end ?) laptop will all
> > support that.
> > Is there any plan to revive this driver for 3.4 or 3.5 ? Should
> > someone repost the last version of the previous patchset for
> > discussion ?
> > And no, on this laptop ALS is definitively not a gadget.
> >
> > Thanks,
> >
> > - http://download.microsoft.com/download/3/0/2/3027D574-C433-412A-A=
8B6-5E0A75D5B237/ambient-light-sensors.docx
>=20
> Adding more people that were interested in the previous discussion.
> What was the exact status of the als class ? Rui Zhang are you still
> interested in this ?
> Thanks,
>=20
well, I need some time to get updated about this.
Say I'm not sure if we still want to introduce an ALS class or we need
to use drivers/staging/iio/ instead, today.

BTW, you own this laptop, right? Can you send me the model name of this
laptop and its acpidump output?

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
