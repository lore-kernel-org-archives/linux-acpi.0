From: Ken Hughes <khughes-kam3zbT8ll8@public.gmane.org>
Subject: Re: Re: S4bios support for 2.5.63
Date: Wed, 5 Mar 2003 23:42:26 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030306074226.GC750@budgie.we1.client2.attbi.com>
References: <20030306072229.GA750@budgie.we1.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030306072229.GA750-peapQs0eLv2IgHrOsx/gaWNy84NFWbr7VpNB7YpNyf8@public.gmane.org>; from khughes-kam3zbT8ll8@public.gmane.org on Wed, Mar 05, 2003 at 23:22:29 -0800
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Ken Hughes <khughes-kam3zbT8ll8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 2003.03.05 23:22 Ken Hughes wrote:
> On Tue, 2003-03-04 at 12:39, Roger Luethi wrote:
>> On Tue, 04 Mar 2003 11:06:50 +1300, Nigel Cunningham wrote:
>> > You were hitting the BUG_ON before swsusp was even trying to write 
>> the
>> > image?!! That is interesting! Since count_and_copy is first called 
>> post
>> > driver suspend in the current version, perhaps they are somehow 
>> related.
>> > (This is before swsusp tries to write any of the image to disk).
>> 
>> Huh? After a glance at the code I agree that drivers_suspend happens 
>> before
>> count_and_copy_data_pages, but that means hitting the BUG_ON in
>> idedisk_suspend before the panic in count_and_copy_data_pages is 
>> what I'd
>> expect. How is that remarkable? ... My current kernel has HIGHMEM 
>> enabled,
>> but previous ones that failed the same way didn't.
> 
> I was surprised because I thought you were getting the BUG_ON during
> writing the image. Now I see that it's well beforehand.
> 
>> Anyway, a few more tests showed that hdparm -u1 helps if I have lots 
>> of
>> memory used (say for fs caches). In two out of two tests, I saw 
>> Pavel's
>> request to send him 1 GB RAM via email.
> 
> On this topic, would you be willing to test a 2.4 version that 
> supported
> highmem? I haven't written support yet, but hope to do it shortly. (I
> don't have that much ram myself so you can send me 1GB if you prefer
> :>).
>> Suspending directly from a clean boot (after issuing the same hdparm 
>> -u1
>> commands for both disks) I hit the BUG_ON in idedisk_suspend (two ut 
>> of
>> two tests, too).

Not sure if this helps any, but I just tried S4 on my Toshiba Satellite 
5105
under 2.5.64 (the first time I've been able to get 2.5.x to boot with 
any
ACPI support).  From the root login I've been able to do
     echo "4" >/proc/acpi/sleep
and get suspend/resume to work fine.  I then tried it from X11R6 and got
the "kernel BUG at drivers/ide/ide-disk.c:1557!" error.

I tried debugging this a little and was surprised to find that I only 
get
this oops about half the time while running X:  the other half this 
system
completes the suspend, and resume brings me right back where I left off
(which would be nice; this doesn't work under 2.4.20).

I also noticed that when the suspend works, the "freeing memory: ....."
messages prints out about 100 periods.  The first 20 or so come slowly,
then it zips through most of the others.  When it oops's, it prints out
about 15 or so periods before the panic.  This seems similar to what 
Bert was
saying in an earlier message:

> Sure, I get this too:
> 
> It now says (copied by hand):
> 
>         freeing memory: .....................|
> (this 'freeing' takes ages, around 30 seconds, while in progress, the 
> disk
>  light blinks every once in a while, perhaps each time while a dot is 
> being
> printed)
>         syncing disks
>         suspending devices

FWIW, I have one hard drive and I'm using ext3 file systems.

----
Ken




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
