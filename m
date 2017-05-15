From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] Revert "ACPI / button: Change default behavior to
 lid_init_state=open"
Date: Mon, 15 May 2017 09:45:53 +0200
Message-ID: <20170515074553.GJ30987@mail.corp.redhat.com>
References: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
 <20170511094551.GF30987@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CEA2CC4@SHSMSX101.ccr.corp.intel.com>
 <2574646.jh0JF0mi0Y@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757270AbdEOHp6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 May 2017 03:45:58 -0400
Content-Disposition: inline
In-Reply-To: <2574646.jh0JF0mi0Y@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Jiri Eischmann <jeischma@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On May 12 2017 or thereabouts, Rafael J. Wysocki wrote:
> On Friday, May 12, 2017 02:36:20 AM Zheng, Lv wrote:
> > Hi, 
> > 
> > > From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> > > Subject: Re: [PATCH 2/2] Revert "ACPI / button: Change default behavior to lid_init_state=open"
> > > 
> > > On May 11 2017 or thereabouts, Zheng, Lv wrote:
> > > > Hi,
> > > >
> > > > > From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> > > > > Subject: [PATCH 2/2] Revert "ACPI / button: Change default behavior to lid_init_state=open"
> > > > >
> > > > > This reverts commit 77e9a4aa9de10cc1418bf9a892366988802a8025.
> > > > >
> > > > > Even if the method implementation can be buggy on some platform,
> > > > > the "open" choice is worse. It breaks docking stations basically
> > > > > and there is no way to have a user-space hwdb to fix that.
> > > > >
> > > > > On the contrary, it's rather easy in user-space to have a hwdb
> > > > > with the problematic platforms. Then, libinput (1.7.0+) can fix
> > > > > the state of the LID switch for us: you need to set the udev
> > > > > property LIBINPUT_ATTR_LID_SWITCH_RELIABILITY to 'write_open'.
> > > > >
> > > > > When libinput detects internal keyboard events, it will
> > > > > overwrite the state of the switch to open, making it reliable
> > > > > again. Given that logind only checks the LID switch value after
> > > > > a timeout, we can assume the user will use the internal keyboard
> > > > > before this timeout expires.
> > > > >
> > > > > For example, such a hwdb entry is:
> > > > >
> > > > > libinput:name:*Lid Switch*:dmi:*svnMicrosoftCorporation:pnSurface3:*
> > > > >  LIBINPUT_ATTR_LID_SWITCH_RELIABILITY=write_open
> > > >

[...]

> 
> Well, if it worked in a specific way that users depended on before the commit in
> question and now it works differently, then it does break things.
> 
> Benjamin, my understanding is that this is the case, is it correct?

That is correct. This patch I reverted introduces regression for professional
laptops that expect the LID switch to be reported accurately.

Cheers,
Benjamin
