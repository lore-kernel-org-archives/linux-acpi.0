From: Rob Miller <rob-7HoZ3oJp7ZtBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [Swsusp] Re: ACPI button module - USB interaction during unload
 (Michael Frank)
Date: Thu, 15 May 2003 21:31:49 +0100 (WAT)
Sender: linux-usb-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.21.0305152056200.17491-100000@vista.rtm.home>
References: <200305160217.08067.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200305160217.08067.mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Errors-To: linux-usb-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:linux-usb-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Luis Miguel Pires Neves <lneves-3+EeCmRbAIo+BYJ/izffpQ@public.gmane.org>, linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 16 May 2003, Michael Frank wrote:

> On Friday 16 May 2003 01:35, Luis Miguel Pires Neves wrote:
> > This interaction is perhaps also the cause of the failure to unload
> > usbcore when using acpid to
> > trigger suspension (swsusp) and one presses the power button, in
> > kernel 2.4.20 + acpi20021212 + swsusp beta19-16 and older versions.
> >
> 
> Yes!, _exectly_ this has been reported by Rob Miller on a toshiba. 
> 
> Suggest to liase with him if you got a toshiba and this problem.

That would be me....  

Although I see that there is a problem which Michael has verified between
button.o and the uhci/ohci USB modules, I'm not yet convinced that it is
the only button.o problem.  Nor have I tested for the problem I've found
without having USB loaded, so it could well be the same thing.  I'm now on
the hook to put together some perl lectures, so I thought I would pass on
the info I have worked out to see if someone else can verify or get
further with it before I get back to playing.

As Luis describes, the problem appears when one tells acpid to call
hibernate instead of /sbin/init 0 when the powerbutton is pressed
(/etc/acpi/powerbtn.sh).  Well done to Luis for identifying that it was
related to this specifically, I've been moaning about the problem for
weeks on the swsusp list and wondering why no one else saw what I did.

Specifically, having done this, SIGTERM seems to stop working after a
couple of suspend/resume cycles.  acpid, irattach, uhci (the module),
pcmcia cardmgr and more all stop seeing SIGTERMs, and I had gone through
and put 'kill -9's after all the start-stop-daemon calls in my init
scripts to deal with this.  

After Michael's suggestion that I *really* needed all the USB code as
modules for swsusp, I sprinkled some debug statements into
drivers/usb/hub.c (amongst other files :-); in particular I came across 

----
void usb_hub_cleanup(void)
{
        int ret;

        /* Kill the thread */
        info("usb hub cleanup: kill proc pid %d ",khubd_pid); //rtm
        ret = kill_proc(khubd_pid, SIGTERM, 1);
        info("usb hub cleanup: waiting "); //rtm
        wait_for_completion(&khubd_exited);
        info("usb hub cleanup: kill finished "); //rtm
---

this is called unloading usbcore.o (IIRC), and the other relevant code is
part of khubd:

---
static int usb_hub_thread(void *__hub) 
{ 

...

   /* Send me a signal to get me die (for debugging) */ 
   do { 
         usb_hub_events(); 
         wait_event_interruptible(khubd_wait,!list_empty(&hub_event_list));  
           if (current->flags & PF_FREEZE) 
                  refrigerator(PF_IOTHREAD); 
   } while (!signal_pending(current)); 
 
   dbg("usb_hub_thread exiting"); 
---

This appears to be looking for almost any signal, so I found that I could
clear the swsusp hang unloading usbcore.o by switching to another terminal
and sending a SIGUSR1 to the khubd pid printed in my debug message above.

It was pretty much just luck while laboriously trying different module
combinations that I finally realised it was only happening when I went
back to using the power button to trigger the suspend; I did know that the
problem also disappeared booting with acpi=off (but who wants to do
that? ;-).

Now I've switched to using a hotkey combination to trigger the suspend and
all the SIGTERM problems have completely cleared up.

Current software: 2.4.21-rc1, ACPI 20030424, swsusp 19.27

Can anyone shed some more light on this ?

cheers,

rob.








-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
