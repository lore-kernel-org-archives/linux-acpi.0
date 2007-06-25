From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch] Reporting the lid status using INPUT
Date: Mon, 25 Jun 2007 22:24:59 +0100
Message-ID: <1182806699.2299.16.camel@work>
References: <freemail.20070525224936.77205@fm01.freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:15380 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbXFYVZs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jun 2007 17:25:48 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1380990ugf
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jun 2007 14:25:47 -0700 (PDT)
In-Reply-To: <freemail.20070525224936.77205@fm01.freemail.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Bart=F3k?= Albert <a_bartok@freemail.hu>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>, David Zeuthen <david@fubar.dk>, linux-kernel <linux-kernel@vger.kernel.org>, len.brown@intel.com

On Mon, 2007-06-25 at 22:49 +0200, Bart=C3=B3k Albert wrote:
> GMail On 16/06/07, Dmitry Torokhov <dtor@insightbb.com> wrote:
> > On Saturday 16 June 2007 13:11, Richard Hughes wrote:
> > > On Fri, 2007-06-15 at 15:53 +0100, Richard Hughes wrote:
> > > > On Fri, 2007-06-15 at 10:29 -0400, Dmitry Torokhov wrote:
> > > > > On 6/15/07, Richard Hughes <hughsient@gmail.com> wrote:
> > > > > > On Fri, 2007-06-15 at 13:29 +0100, Richard Hughes wrote:
> > > > > > > in response to an event, but I'm thinking in a resume hoo=
k we should
> > > > > > > probably do acpi_evaluate_integer(handle, "_LID", NULL, &=
state) and then
> > > > > > > send an event, just so userspace is aware of what the sta=
te of the panel
> > > > > > > is.
> > > > > >
> > > > > > Attached patch fixed the issue for me. Comments?
> > > > > >
> > > > >
> > > > > The patch makes perfect sense. The only issue I have is this:
> > > > >
> > > > > > +       /* on resume we send the state; it might be the sam=
e, but userspace
> > > > > > +        * should handle duplicated events */
> > > > >
> > > > > If switch state matches to what input layer thinks it is the =
event
> > > > > will not even reach userspace.
> > > >
> > > > Okay, new patch attached, thanks for the speedy review.
> > >
> > > This fix is also confirmed by somebody else, see
> > > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D243030
> > >
> > > It would be great if this could go into .22, although I appreciat=
e it's
> > > quite late in the day.
> > >
> >
> > This is of course Len's call but in my book this is a bugfix and as=
 such
> > is appropriate for -rc4/rc5.
>=20
> > Guys? Any ack-nak?
>=20
> works perfectly for me so far.

Thanks. Len, can you add this to your tree please. Thanks.

Richard.


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
