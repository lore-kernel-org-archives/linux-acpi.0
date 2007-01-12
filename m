From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works again after booting windows
Date: Fri, 12 Jan 2007 13:51:50 +0800
Message-ID: <3877989d0701112151m6816cd4fl4f2a2bdf309d51ac@mail.gmail.com>
References: <457F37C0.3090003@gmail.com> <1165966936.29844.37.camel@pcjc2lap>
	 <457FB1A1.2030602@gmail.com> <1166012707.22903.4.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:47133 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030489AbXALFvv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jan 2007 00:51:51 -0500
Received: by wx-out-0506.google.com with SMTP id h31so737815wxd
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jan 2007 21:51:50 -0800 (PST)
In-Reply-To: <1166012707.22903.4.camel@pcjc2lap>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: linux-acpi@vger.kernel.org, "Lincoln Baxter, III" <lincolnbaxter@gmail.com>

Since it is somewhat related to ACPI, please open a bug in ACPI
category on bugzilla.kernel.org. It is a great place to track this
kind of issues.

On 12/13/06, Peter Clifton <pcjc2@cam.ac.uk> wrote:
> On Wed, 2006-12-13 at 02:54 -0500, Lincoln Baxter, III wrote:
> > Wow. You're completely right... so this isn't an ACPI issue (directly.)
> >
> > I don't seem to experience any of the other problems you describe, but I
> > do have a different model. I don't have an external lid-switch sensor.
> > Hm.. Suspend doesn't quite work for me either, I'll look into this
> > farther and get back to you.
> >
> > The battery meters and other ACPI functionality is working now with your
> > workaround. Should this be a bug report? Which group should get the
> > report if this is the case?
> >
> > Thanks so much!
> > Lincoln
>
> It was suggested to me to open a kernel bug (possibly starting under
> ACPI), however I never got to it.. I don't know where kernel bugs are
> reported officially, and was busy at the time. (still am). I do try and

bugzilla.kernel.org

> reply to others with the same problems though... finding the webpage
> which suggested that fix was not trivial!

It is not easy to track it in emals.

>
> My lid switch is just above the keyboard, on the right hand side of the
> left hand screen hinge. It is just a tiny piece of plastic protruding
> from the case. Push it, and the screen goes off. Hold it, and wiggle the
> mouse (touchpad), and the naughty screen comes back on.
>
> Most importantly for me, the workaround brings the max CPU speed
> available with speed step back to what it is supposed to be on my
> laptop, and the BIOS actually boots much faster.
>
