From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [PATCH] 2.4.23-pre3 ACPI fixes series (1/3)
Date: Wed, 10 Sep 2003 22:27:09 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309102227.09096.adq_dvb@lidskialf.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060115.24340.adq_dvb@lidskialf.net> <Pine.LNX.4.56.0309101344420.20323@dot.kde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.56.0309101344420.20323-CpmL+rkjyb1AfugRpC6u6w@public.gmane.org>
Content-Disposition: inline
To: Bernhard Rosenkraenzer <bero-9zdaV+82baBg9hUCZPvPmw@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 10 Sep 2003 12:45 pm, Bernhard Rosenkraenzer wrote:
> On Sat, 6 Sep 2003, Andrew de Quincey wrote:
> > This patch allows ACPI to drop back to PIC mode if ACPI mode setup fails.
>
> Works nicely here, but causes an oops on startup if you specify acpi=off
> on the command line.

Thanks for reporting that. Andi Kleen beat to me patching it.. He posted it to 
LKML and acpi-devel a day or so ago.. 
