From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Bug 197863] Thinkpad X240 resume dramatically slower on kernels 4.13+
Date: Fri, 9 Feb 2018 22:26:34 +0100
Message-ID: <CAJZ5v0gLByRcv8KEemmX6FX7yDt==AUu3wyVBHR4oYHqgRtXdw@mail.gmail.com>
References: <bug-197863-190391@https.bugzilla.kernel.org/> <a662d85c-e226-223e-3467-90b651dd291b@intel.com>
 <CAJZ5v0jN2cQUmwWRQ=Rvb+dQpMg+Q+GuaDtt-X-tXWNThUx-NQ@mail.gmail.com>
 <4333304.2V78SBapX3@aspire.rjw.lan> <20180209134309.cvhst6x24chx4adz@victor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180209134309.cvhst6x24chx4adz@victor>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Demleitner <m@tfiu.de>
Cc: ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 9, 2018 at 2:43 PM, Markus Demleitner <m@tfiu.de> wrote:
> On Thu, Feb 08, 2018 at 08:12:06PM +0100, Rafael J. Wysocki wrote:
>> On Wednesday, February 7, 2018 11:44:15 PM CET Rafael J. Wysocki wrote:
>> > On Mon, Feb 5, 2018 at 6:06 PM, Rafael J. Wysocki
>> > <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> > > On 2/5/2018 3:14 PM, Bj=C3=B8rn Mork wrote:
>> > >>
>> > >> "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
>> > >>>
>> > >>> On 2/4/2018 9:28 PM, Bj=C3=B8rn Mork wrote:
>> > >>>
>> > >>>> But I do wonder if the attached (completely untested!!) patch mak=
es
>> > >>>> things any better?
>> > >>>
>> > >>> I don't think so, the macro is needed too.
>> > >>
>> > >> Doh! Obviously.  Don't know how I managed to miss that.
>> > >>
>> > >>> I'll queue up a full revert of 662591461c4b9a1e3b.
>> > >>
>> > >> Still with the additional exception for "ec =3D=3D first_ec"?
>> > >>
>> > >
>> > > No, just a full revert for now.
>> >
>> > That doesn't work, because we made some changes on top of this commit.
>> >
>> > I'll send a patch to try tomorrow.
>>
>> Below is a patch for the mainline (should be applicable to 4.15.y) to te=
st.
>> Please let me know if it improves things for you.
>
> It pretty certainly does (patch applied on top of 4.15.0 from
> tarball).  Five out of five wakeup cycles were fast, and the cell
> modem is still properly initialised -- the message went out via the
> resumed modem.

OK, let's do it, then.

Thanks for testing!
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
