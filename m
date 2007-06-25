From: =?ISO-8859-2?Q?Bart=F3k_Albert?= <a_bartok@freemail.hu>
Subject: Re: [patch] Reporting the lid status using INPUT
Date: Mon, 25 Jun 2007 22:49:36 +0200 (CEST)
Message-ID: <freemail.20070525224936.77205@fm01.freemail.hu>
References: <15e53e180706241506p53ec648ib93d684bbe076a46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754225AbXFYU41@vger.kernel.org>
In-Reply-To: <15e53e180706241506p53ec648ib93d684bbe076a46@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: GMail <hughsient@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>, David Zeuthen <david@fubar.dk>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org





GMail On 16/06/07, Dmitry Torokhov <dtor@insightbb.com> wrote:
> On Saturday 16 June 2007 13:11, Richard Hughes wrote:
> > On Fri, 2007-06-15 at 15:53 +0100, Richard Hughes wrote:
> > > On Fri, 2007-06-15 at 10:29 -0400, Dmitry Torokhov wrote:
> > > > On 6/15/07, Richard Hughes <hughsient@gmail.com> wrote:
> > > > > On Fri, 2007-06-15 at 13:29 +0100, Richard Hughes wrote:
> > > > > > in response to an event, but I'm thinking in a resume hook =
we should
> > > > > > probably do acpi_evaluate_integer(handle, "_LID", NULL, &st=
ate) and then
> > > > > > send an event, just so userspace is aware of what the state=
 of the panel
> > > > > > is.
> > > > >
> > > > > Attached patch fixed the issue for me. Comments?
> > > > >
> > > >
> > > > The patch makes perfect sense. The only issue I have is this:
> > > >
> > > > > +       /* on resume we send the state; it might be the same,=
 but userspace
> > > > > +        * should handle duplicated events */
> > > >
> > > > If switch state matches to what input layer thinks it is the ev=
ent
> > > > will not even reach userspace.
> > >
> > > Okay, new patch attached, thanks for the speedy review.
> >
> > This fix is also confirmed by somebody else, see
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D243030
> >
> > It would be great if this could go into .22, although I appreciate =
it's
> > quite late in the day.
> >
>
> This is of course Len's call but in my book this is a bugfix and as s=
uch
> is appropriate for -rc4/rc5.

> Guys? Any ack-nak?

works perfectly for me so far.

Albert



15% KEDVEZM=C9NY minden PLASZTIKAI M=DBT=C9TRE az Aesthetica orvosi k=F6=
zpontban! Klikk ide!http://www.webdesign.hu/aesthetica/flash_microsite/=
?id=3D9;p_code=3D2079
