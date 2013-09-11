From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: loading 'acpiphp' fails =?utf-8?Q?afte?=
 =?utf-8?B?ciB0aGUgc3lzdGVtIGJvb3Q/4oCP?=
Date: Wed, 11 Sep 2013 10:58:50 -0700
Message-ID: <20130911175850.GA32469@kroah.com>
References: <SNT149-W205633FE9047D530867E639A380@phx.gbl>
 <20130910155103.GB22628@kroah.com>
 <SNT149-W11D153D65E31824ED6AE2E9A390@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hotplug-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SNT149-W11D153D65E31824ED6AE2E9A390@phx.gbl>
Sender: linux-hotplug-owner@vger.kernel.org
To: Shiro Itou =?utf-8?B?5LyK5p2x?= <shiro.itou@outlook.com>
Cc: "linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Sep 11, 2013 at 10:46:19AM -0700, Shiro Itou =E4=BC=8A=E6=9D=B1=
 wrote:
> ----------------------------------------
> > Date: Tue, 10 Sep 2013 08:51:03 -0700
> > From: gregkh@linuxfoundation.org
> > To: shiro.itou@outlook.com
> > CC: linux-hotplug@vger.kernel.org; linux-acpi@vger.kernel.org
> > Subject: Re: loading 'acpiphp' fails after the system boot?=E2=80=8F
> >
> > On Tue, Sep 10, 2013 at 08:43:05AM -0700, Shiro Itou =E4=BC=8A=E6=9D=
=B1 wrote:
> >> Hi All,
> >>
> >> In kernel version 3.0, when =E2=80=98apciphp=E2=80=99 driver modul=
e is loaded, after
> >> the system comes up, it fails with error =E2=80=9Cno such device=E2=
=80=9D. When I
> >> tried to debug I see that it fails in acpiphp_get_num_slots ()
> >> function with error "Total 0 slots". In this case =E2=80=98bridge_=
list=E2=80=99 seem
> >> to be NULL.
> >> But when the =E2=80=98acpiphp=E2=80=99 is loaded during boot time,=
 it seems to work file.
> >
> > What happens in the 3.11 kernel release? Lots of work has been done=
 in
> > this area in the past 2 years, please try a newer kernel. If there =
are
> > still problems, please let the linux-pci@vger.kernel.org mailing li=
st
> > know about it.
>=20
> Thank you for reply. I did not try 3.11 kernel. I will check 3.11
> kernel and see. But I use 3.0 kernel as a requirement.

Then please contact the people who is in charge of that requirement, as
they are the only ones that can support you, the community can not.

Best of luck,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-hotplug=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
