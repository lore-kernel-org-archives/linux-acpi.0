From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH][2.4] acpi S5 poweroff fix
Date: Wed, 30 Apr 2003 15:42:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030430134200.GF2954@poup.poupinou.org>
References: <20030429181518.96485.qmail@web41601.mail.yahoo.com> <03ea01c30f11$53ec94a0$3746028e@bio.dfo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <03ea01c30f11$53ec94a0$3746028e-dP0OE4Ef7fWw5LPnMra/2Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>
Cc: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 30, 2003 at 09:09:19AM -0300, Derek Broughton wrote:
> From: "willy tarreau" <wtarreau-Qt13gs6zZMY@public.gmane.org>
> 
> > Although I'm not sure that the second case affects everybody, because it might
> > be caused by side-effects, but from what I've understood from the code, I'm
> > pretty sure that nobody can power off by echoing 5 to /proc/acpi/sleep !
> 
> Mostly we wouldn't want to.  iirc, there was some discussion here about not even
> permitting "echo 5 >/proc/acpi/sleep".

This is done afaik in 2.5 and I supposed it was done in 2.4 as well.

> If I am forced to recover from the (too
> frequent) situation where my laptop freezes and ignores the keyboard, I have to
> hold down the power button for 4 or 5 seconds, as you mention.  But that, like
> S5, is an abrupt power-off.  Generally, I'd want to go through init and do it
> gracefully.  Pushing the power button once is enough to generate a power button
> event in acpi, and then acpid shuts the machine down using '/sbin/init 0'
> 

I must admit that I don't have
a real point-of-view about allowing 'echo 5 > /proc/acpi/sleep'
or not.

One 'pro', for example, is to permit ospmd (or acpid)
to enter this state if a critical thermal event occur.

For me, that is more a debate of what have to be done in
userspace vs in-kernel in ACPI in general.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
