From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Regression: BUG when battery is removed before resuming from hibernation
Date: Tue, 8 Jun 2010 22:52:49 +0200
Message-ID: <201006082252.49452.rjw@sisk.pl>
References: <4C0E40E1.2080108@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C0E40E1.2080108-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Cc: Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 08 June 2010, Alan Jenkins wrote:
> I found this bug 2.6.34 on my Asus EeePC 701 (x86_32 arch).  It didn't 
> happen to me before, when I was running nearly-2.6.33 or 2.6.32-release.
> 
> I used git-bisect, but unfortunately the result isn't very helpful.  My 
> next step will be to try to narrowing down the culprits by disabling 
> individual CONFIG options.  Here are my results so far, in case anyone 
> is interested.
> 
> 
> == Steps to reproduce ==
> 
> I) Boot off mains power, with battery removed.  Login to KDE4 session, 
> with Konsole as the only running application.
> II) Run "sudo pm-hibernate"
> 
> 1. When the system switches to text mode (a.k.a the console), 
> immediately insert the battery.
> 2. Once the system has fully hibernated, remove the battery.
> 3. Press the power button to resume.  The backtrace below is generated 
> during resume.

You're not supposed to be doing that.

Rafael
