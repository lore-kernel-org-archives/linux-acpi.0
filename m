From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Problem waking Thinkpad G40 from S3 suspend to RAM
Date: Sun, 17 Oct 2004 13:35:28 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.10.17.10.35.26.516538@yahoo.com>
References: <4171DB3C.2070104@openscroll.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I hope you tried with "acpi_sleep=s3_bios" not "acpi_mode=s3_bios" as you
wrote.


On Sat, 16 Oct 2004 19:38:52 -0700, Sudhakar Chandra wrote:

> Hi,
> 
> I have Debian (unstable) installed on my Thinkpad G40.  I have a
> hand-compiled kernel 2.6.8.1 (patched with bootsplash, ACPI and swsusp2
> patches from 10 days ago) that I am using. Most drivers are compiled as
> modules except for framebuufer, bootsplash, swsusp2, etc.
> 
> I am able to hibernate my laptop (i.e. suspend to disk) fine using
> swsusp2. I am also able to suspend my laptop to RAM just fine (passing
> acpi_mode=s3_bios to kernel). My problem is waking up from an S3 suspend
> to RAM sleep.  When suspended, the "sliver / crescent moon" LED comes on
> indicating that the laptop is sleeping.  When I close the lid and reopen
> it, the laptop tries to wake up and I hear a beep.  But nothing shows up
> on the display. The crescent moon LED is also no longer illuminated. I
> know that the laptop has woken up because at this stage I can press the
> power button and initiate a swsusp2 suspend.  When I restart I am able to
> wake up the state that was suspended to disk.
> 
> My questions:
> 
> 1. Has anyone got waking up from S3 suspend to work properly on a G40? If
> so, how?
> 
> 2. I upgraded to the latest BIOS on IBM's support site. If this BIOS is
> still broken, I guess I need to upgrade my DSDT table. Unfortunately, the
> documentation I read refers me to an iasl compiler that I cannot find at
> the indicated site:
> http://developer.intel.com/technology/iapc/acpi/downloads.htm
> 
> 3. Is there a way to invoke swsusp2 on S4 suspend?
> 
> I tried my experiements above with only acpi modules loaded and nothing
> else in single usermode (with pcmcia, usb, etc., unloaded).
> 
> Thanks.
> 
> Thaths




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
