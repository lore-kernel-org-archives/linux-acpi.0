From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI suspend: Fix compilation warnings in drivers/acpi/sleep.c
Date: Sat, 17 Jan 2009 00:03:51 +0100
Message-ID: <200901170003.52015.rjw@sisk.pl>
References: <200901162309.14778.rjw@sisk.pl> <20090116144933.3ed476f9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932283AbZAPXEz@vger.kernel.org>
In-Reply-To: <20090116144933.3ed476f9.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday 16 January 2009, Andrew Morton wrote:
> On Fri, 16 Jan 2009 23:09:14 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Fix two compilation warnings in drivers/acpi/sleep.c, one triggered
> > by unsetting CONFIG_SUSPEND and the other triggered by unsetting
> > CONFIG_HIBERNATION, by moving some code under the appropriate
> > #ifdefs .
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  arch/x86/kernel/acpi/sleep.c |    4 +--
> >  drivers/acpi/sleep.c         |   51 +++++++++++++++++++++----------------------
> 
> Confused.  drivers/acpi/sleep.c was removed six years ago?

It's back in 2.6.29-rc2. :-)
