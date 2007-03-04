From: emisca <emisca.ml@gmail.com>
Subject: Re: Fan speeds on HP nc6400 and nc8430
Date: Sun, 4 Mar 2007 17:56:36 +0100
Message-ID: <414cba4e0703040856l3ec05f00ne2317cd985f147e8@mail.gmail.com>
References: <C3FA62B1A90D7440B9B6C7C31895994F0366363A@zadbn02100.vodacom.corp>
	 <d120d5000702051149n2f713859na46b8c1b2398e17d@mail.gmail.com>
	 <200702090142.06253.dtor@insightbb.com>
	 <200702101137.21687.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:3116 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbXCDQ4j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Mar 2007 11:56:39 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1062989uga
        for <linux-acpi@vger.kernel.org>; Sun, 04 Mar 2007 08:56:38 -0800 (PST)
In-Reply-To: <200702101137.21687.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

At what kernel are targeted these patches? I have an nx7400, and the
same psmouse problems.... I would like to test them..

2007/2/10, Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> On Friday, 9 February 2007 07:42, Dmitry Torokhov wrote:
> > On Monday 05 February 2007 14:49, Dmitry Torokhov wrote:
> > > Hi,
> > >
> > > On 2/5/07, Thomas Renninger <trenn@suse.de> wrote:
> > > > I have a patch that should fix the psmouse unload thing (at the end).
> > > > Not sure whether it's still needed in 2.6.20-rcX, there was some work
> > > > done... it definitely helps on 2.6.18 and 2.6.16 kernels.
> > > > Ok, I quickly tried on 2.6.20-rc7 and it seems to work without the
> > > > patch.
> > >
> > > Just a limited number of boxes seems to have problems...
> > >
> > > > Maybe Dmitry can comment on that and push this one if still needed?
> > >
> > > I do not like the idea of removing port at shutdown. I will look into
> > > extending psmouse_cleanup so it leaves the port in the same state as
> > > psmouse_disconnect.
> > >
> >
> > Hi,
> >
> > Could you please try the 2 attached patches and let me know if it improves
> > suspend and psmouse iteractions.
>
> On my box (nx6325) it does.  Apparenly, with these two patches applied I don't
> need to unload psmouse before the suspend so that the power management works
> after the resume. :-)
>
> I'll be testing it a bit more today anyway.
>
> Greetings,
> Rafael
>
