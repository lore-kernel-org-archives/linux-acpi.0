From: =?iso-8859-1?Q?Fr=E9d=E9ric?= Bothamy <fbothamy-bGbTDnlUqz99Bbbejix+0A@public.gmane.org>
Subject: Re: CALL FOR TESTING
Date: Fri, 20 Sep 2002 01:29:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020919232938.GA9832@athena.olympe.fr>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE80-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Sep 18, 2002 at 11:27:01PM -0700, Grover, Andrew wrote:
> I wanted to make a special request for testing of the 2.4 patch (or should I
> say, MEGA-patch).
> 
> Marcelo has asked for widespread testing of it, in anticipation of likely
> 2.4 mainline inclusion. I will be posting a call for testing to linux-kernel
> soon, but am posting this here first to hopefully weed out any really bad
> bugs that may have crept in.

Hardware : Compaq Presario 711EA laptop
 
> The main issues of importance are:
> 
> - DOES IT BOOT?

Yes

> - DOES IT ASSIGN INTERRUPTS PROPERLY?

Yes, although the kernel complains about a :

PCI: No IRQ known for interrupt pin A of device 01:00.0 - using IRQ 5

the device 01:00.0 being the video card and this IRQ 5 seems to be
used by the onboard audio as well. But everything is working well
(audio and video).

I can provide the dmesg log and/or the raw dsdt if you ever need it.


Thanks for your work.

Fred


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
