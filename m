From: Aviram Jenik <aviram-koYqR8i3DjZZkMgn48OZqdBPR1lH4CV8@public.gmane.org>
Subject: Re: standby resumes immediately in 2.6.0-test8
Date: Sat, 25 Oct 2003 15:16:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200310251516.50547.aviram@beyondsecurity.com>
References: <200310231630.21392.aviram@beyondsecurity.com> <20031024093006.GA29586@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031024093006.GA29586-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?q?=C9ric=20Brunet?= <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 24 October 2003 11:30, Éric Brunet wrote:
> On Thu, Oct 23, 2003 at 04:30:21PM +0200, Aviram Jenik wrote:
> > Hi,
> >
> > I am trying to get "standby" to work on my Sony vaio laptop. I did:
> > echo -n "standby" > /sys/power/state
> >
> > But this only flashes the screen once (in X this is more noticeable) and
> > resumes immediately.
>
> You might try
>
> sleep 1; echo -n "standby" > /sys/power/state
>
> I have the feeling that the "release key" event othe return key wakes the
> computer up. With the sleep 1; the "release key" event occurs while the
> computer is not yet suspended.
>

I tried it, but that didn't help. I even booted with init=/bin/sh to make sure 
nothing is running (and no modules are loaded) and tried the line above  - 
again the resume was immediate.

It *does* look like something wakes the computer up immediately - but what can 
it be?

- Aviram


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
