From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: [PATCH] 2.6.0-test4: Trivial /sys/power/state patch, sleep status report
Date: Tue, 26 Aug 2003 01:47:50 +0300
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200308260147.50968.p_christ@hol.gr>
References: <200308260125.30194.p_christ@hol.gr> <1061851218.12331.23.camel@gimli.at.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1061851218.12331.23.camel-j7ksBhXOGzoJmsy6czSMtA@public.gmane.org>
Content-Disposition: inline
To: Bernd Petrovitsch <bernd-GBwJepH+xoVeoWH0uzbU5w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Bernd Petrovitsch wrote:
> On Tue, 2003-08-26 at 00:25, P. Christeas wrote:
> > Just found out that by 'echo sth_wrong > /sys/power/state' the kernel
> > would oops in a fatal way (no clean exit from there).
> > The oops suggested that the code would enter an invalid fn.
> >
> > You may apply the included patch to solve the bug. IMHO doing a clean
> > exit is much preferrable than having BUG() there.
>
> > diff -Bbur /diskb/users/panos/linux-off/kernel/power/main.c
> > /usr/src/linux/kernel/power/main.c ---
> > /diskb/users/panos/linux-off/kernel/power/main.c	2003-08-23
> > 12:13:17.000000000 +0300 +++
> > /usr/src/linux/kernel/power/main.c	2003-08-26 00:59:34.000000000 +0300 @@
> > -500,7 +514,7 @@
> >  		if (s->name && !strcmp(buf,s->name))
> >  			break;
> >  	}
> > -	if (s)
> > +	if ( (s) && (state < PM_SUSPEND_MAX) )
> >  		error = enter_state(state);
> >  	else
> >  		error = -EINVAL;
>
> What do you think about the attached patch to solve the bug and remove a
> warning?
>
> 	Bernd

Already tried that. If you look more closely, the s will receive the state 
*before* the name *in it* is strcmp()'ed. This means it won't be NULL anyway.
>               if (s->name && !strcmp(buf,s->name))
>                       break;

I also thought of checking "( (s) && (s->name !=NULL) )" ,  but IMHO the 
'state' check is cleaner (no dereference).


--- linux-2.6.0-test4/kernel/power/main.c       Sat Aug 23 01:53:13 2003
+++ linux-2.6.0-test4-patched/kernel/power/main.c       Mon Aug 25 21:16:50 
2003
@@ -492,7 +492,7 @@
 static ssize_t state_store(struct subsystem * subsys, const char * buf, 
size_t n)
 {
        u32 state;
-       struct pm_state * s;
+       struct pm_state * s = NULL;
        int error;
 
        for (state = 0; state < PM_SUSPEND_MAX; state++) {
