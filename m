From: Bernhard Rosenkraenzer <bero-9zdaV+82baBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] 2.4.23-pre3 ACPI fixes series (1/3)
Date: Wed, 10 Sep 2003 13:45:57 +0200 (CEST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.56.0309101344420.20323@dot.kde.org>
References: <200309051958.02818.adq_dvb@lidskialf.net>
 <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com>
 <200309060115.24340.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200309060115.24340.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 6 Sep 2003, Andrew de Quincey wrote:

> This patch allows ACPI to drop back to PIC mode if ACPI mode setup fails.

Works nicely here, but causes an oops on startup if you specify acpi=off 
on the command line.

LLaP
bero
