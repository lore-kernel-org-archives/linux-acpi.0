From: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: performance problems?
Date: Tue, 19 Nov 2002 15:01:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021119150155.406f1c92.nils@kernelconcepts.de>
References: <3DDA3E96.50906@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DDA3E96.50906-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas List <Thomas.List-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 19 Nov 2002 14:37:26 +0100
Thomas List <Thomas.List-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org> wrote:
> Hi all,
Hello!

> I'm working on a small battery applet for my laptop that reads out the
> battery status. As I have up to now no better idea I'm pulling the 
> battery status (/proc/acpi/battery/...) every few seconds (anyone an 
> idea of how to do this better?). Now a battery applet should consume
> as few CPU cycles as possible to not use up the battery itself. So I'm
> trying to monitor how much computing time my applet is using. For the 
> moment I'm doing this using top (I know this is not perfect for that 
> task ...). Now to the problem:

IMHO your assumption are coorect.

> After the laptop is running for some time the CPU% value in top is 
> getting higher and higher. It starts with around 0.3% in the
> beginning, after one hour it reaches 1,5% and I had it up to 3% and
> more after a longer time. I am quite sure this is not my applet - I
> can stop the program and restart it and still get the higher values. I
> tried to watch a video in this state and while my program was running
> I had short stops in the video play back that match the 2 seconds
> interval of pulling the battery status. Without my program running the
> stops disappeared. Using a file system copy of /proc/acpi my program
> does not show at all on the top list.

I cannot explain what you are observing but I can confirm your
observations. I see the same "hangs" and CPU usage phenomenon when using
a window-maker dock application showing battery information. Everytime
the battery is polled by the applet the CPU usage rises and the machine
suffers a short hang; approx. 1/4 second.

> I am using acpi 20021111 on a 2.4.20-rc1 kernel. The laptop is a Targa
> visionary 1600 from actebis (mobile athlon on a Via ProSavage KN133 
> "TwisterK" board). I think I did not have such problems with an older 
> acpi version (20021022 ???) - I will check this out).

Same here.
Laptop is Asus L3800C.

> Now could this be a problem with the acpi implementation or is this
> the result of a wrong usage of acpi?

I think this is a problem with ACPI...

> Btw. - is there any documentation on the /proc/acpi directories
> besides Dominik Brodowski's documentation for /proc/acpi/processor?

AFAIK not; but would be nice!

> Thanks for any help,
>    Thomas
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
