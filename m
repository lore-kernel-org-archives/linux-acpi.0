From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 3/3] ACPI / button: Add quirks for initial lid state
 notification
Date: Thu, 02 Jun 2016 16:01:50 +0200
Message-ID: <1464876110.2432.31.camel@hadess.net>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>	
	 <284674cb8228f4f2b40f940a3c4a666f367d7b6a.1464775699.git.lv.zheng@intel.com>	
 <1464778871.2432.12.camel@hadess.net>
	 <1AE640813FDE7649BE1B193DEA596E883BBB7382@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBB7382@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2016-06-02 at 01:08 +0000, Zheng, Lv wrote:
> Hi,
>=20
> > From: Bastien Nocera [mailto:hadess@hadess.net]
> > Subject: Re: [PATCH v3 3/3] ACPI / button: Add quirks for initial
> > lid state
> > notification
> >=20
> > On Wed, 2016-06-01 at 18:10 +0800, Lv Zheng wrote:
> > > Linux userspace (systemd-logind) keeps on rechecking lid state
> > > when the
> > > lid state is closed. If it failed to update the lid state to open
> > > after
> > > boot/resume, the system suspending right after the boot/resume
> > > could
> > be
> > > resulted.
> > > Graphics drivers also uses the lid notifications to implment
> > > MODESET_ON_LID_OPEN option.
> >=20
> > "implement"
> [Lv Zheng]=C2=A0
> Thanks for pointing out, I'll send an UPDATE to this.
>=20
> >=20
> > > Before the situation is improved from the userspace and from the
> > graphics
> > > driver, users can simply configure ACPI button driver to send
> > > initial
> > > "open" lid state using button.lid_init_state=3Dopen to avoid such
> > > kind of
> > > issues. And our ultimate target should be making
> > > button.lid_init_state=3Dignore the default behavior. This patch
> > > implements
> > > the 2 options and keep the old behavior
> > > (button.lid_init_state=3Dmethod).
> >=20
> > I still don't think it's reasonable to expect any changes in user-
> > space
> > unless you start documenting what the API to user-space actually
> > is.
> [Lv Zheng]=C2=A0
> IMO, the ACPI lid driver should be responsible for sending lid key
> event (especially "close") to the user space.
> So if someone need to implement an ACPI lid key event quirk, we could
> help to implement it from the kernel space.
> And since the initial lid state is not stable, we have to stop doing
> quirks around it inside of the Linux kernel, or inside of the
> customized AML tables.
> User space can still access /proc/acpi/button/lid/LID0/state, but
> should stop thinking that it is reliable.
>=20
> These are what I can conclude from the bugs.

There's still no documentation for user-space in the patch, and no way
to disable the "legacy" support (disabling access to the cached LID
state, especially through the input layer which is what logind and
upower use).

You can't expect user-space to change in major ways for those few
devices if the API doesn't force them to, through deprecation notices
and documentation.

Cheers
