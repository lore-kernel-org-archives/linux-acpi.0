From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch] Reporting the lid status using INPUT
Date: Sat, 16 Jun 2007 18:11:51 +0100
Message-ID: <1182013911.2309.4.camel@work>
References: <1181910567.4819.7.camel@work> <1181913179.21041.3.camel@work>
	 <d120d5000706150729i24763e00o7d2c48ef16960b2f@mail.gmail.com>
	 <1181919208.2681.6.camel@work>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:44560 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbXFPRNI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jun 2007 13:13:08 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1089103ugf
        for <linux-acpi@vger.kernel.org>; Sat, 16 Jun 2007 10:13:05 -0700 (PDT)
In-Reply-To: <1181919208.2681.6.camel@work>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, a_bartok@freemail.hu, Bastien Nocera <hadess@hadess.net>, David Zeuthen <david@fubar.dk>, linux-kernel <linux-kernel@vger.kernel.org>

On Fri, 2007-06-15 at 15:53 +0100, Richard Hughes wrote:
> On Fri, 2007-06-15 at 10:29 -0400, Dmitry Torokhov wrote:
> > On 6/15/07, Richard Hughes <hughsient@gmail.com> wrote:
> > > On Fri, 2007-06-15 at 13:29 +0100, Richard Hughes wrote:
> > > > in response to an event, but I'm thinking in a resume hook we should
> > > > probably do acpi_evaluate_integer(handle, "_LID", NULL, &state) and then
> > > > send an event, just so userspace is aware of what the state of the panel
> > > > is.
> > >
> > > Attached patch fixed the issue for me. Comments?
> > >
> > 
> > The patch makes perfect sense. The only issue I have is this:
> > 
> > > +	/* on resume we send the state; it might be the same, but userspace
> > > +	 * should handle duplicated events */
> > 
> > If switch state matches to what input layer thinks it is the event
> > will not even reach userspace.
> 
> Okay, new patch attached, thanks for the speedy review.

This fix is also confirmed by somebody else, see
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=243030

It would be great if this could go into .22, although I appreciate it's
quite late in the day.

Richard.


