From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Fri, 12 Jun 2009 10:15:19 +0200
Message-ID: <200906121015.19504.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0906112210340.21931-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933056AbZFLIOt@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0906112210340.21931-100000@netrider.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Am Freitag, 12. Juni 2009 04:16:10 schrieb Alan Stern:
> What tree constraint? =A0You mean that the PM core shouldn't allow
> devices to suspend unless all their children are suspended? =A0Why
> doesn't it still apply?

Because the hardware doesn't need it.

> Remember, when Rafael and I say "suspend" here, we don't mean "go to =
a
> low-power state". =A0We mean "the PM core calls the runtime_suspend
> method". =A0No matter what actions the link hardware may decide to ta=
ke
> on its own, the PM core will still want to observe the
> all-children-suspended restriction when calling runtime_suspend
> methods.

No. The core if it insists all children be suspended will not use
the hardware's full capabilities.
If it leaves such power saving measures to the drivers, latency
accounting will be wrong.

> > I think there are devices who can be suspended while children are a=
ctive
> > and devices which can not be. This is an attribute of the device an=
d
> > should be evaluated by the core.
>
> Clearly it should be decided by the driver. =A0Should there be a bit =
for
> it in the dev_pm_info structure?

Yes.

	Regards
		Oliver
