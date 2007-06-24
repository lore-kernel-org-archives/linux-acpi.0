From: GMail <hughsient@gmail.com>
Subject: Re: [patch] Reporting the lid status using INPUT
Date: Sun, 24 Jun 2007 23:06:37 +0100
Message-ID: <15e53e180706241506p53ec648ib93d684bbe076a46@mail.gmail.com>
References: <1181910567.4819.7.camel@work> <1181919208.2681.6.camel@work>
	 <1182013911.2309.4.camel@work> <200706161351.28885.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:46177 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbXFXWGi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Jun 2007 18:06:38 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1168671ugf
        for <linux-acpi@vger.kernel.org>; Sun, 24 Jun 2007 15:06:37 -0700 (PDT)
In-Reply-To: <200706161351.28885.dtor@insightbb.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, a_bartok@freemail.hu, Bastien Nocera <hadess@hadess.net>, David Zeuthen <david@fubar.dk>, linux-kernel <linux-kernel@vger.kernel.org>

On 16/06/07, Dmitry Torokhov <dtor@insightbb.com> wrote:
> On Saturday 16 June 2007 13:11, Richard Hughes wrote:
> > On Fri, 2007-06-15 at 15:53 +0100, Richard Hughes wrote:
> > > On Fri, 2007-06-15 at 10:29 -0400, Dmitry Torokhov wrote:
> > > > On 6/15/07, Richard Hughes <hughsient@gmail.com> wrote:
> > > > > On Fri, 2007-06-15 at 13:29 +0100, Richard Hughes wrote:
> > > > > > in response to an event, but I'm thinking in a resume hook we should
> > > > > > probably do acpi_evaluate_integer(handle, "_LID", NULL, &state) and then
> > > > > > send an event, just so userspace is aware of what the state of the panel
> > > > > > is.
> > > > >
> > > > > Attached patch fixed the issue for me. Comments?
> > > > >
> > > >
> > > > The patch makes perfect sense. The only issue I have is this:
> > > >
> > > > > +       /* on resume we send the state; it might be the same, but userspace
> > > > > +        * should handle duplicated events */
> > > >
> > > > If switch state matches to what input layer thinks it is the event
> > > > will not even reach userspace.
> > >
> > > Okay, new patch attached, thanks for the speedy review.
> >
> > This fix is also confirmed by somebody else, see
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=243030
> >
> > It would be great if this could go into .22, although I appreciate it's
> > quite late in the day.
> >
>
> This is of course Len's call but in my book this is a bugfix and as such
> is appropriate for -rc4/rc5.

Guys? Any ack-nak?

Richard.
